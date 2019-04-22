package main

import (
	"encoding/json"
	"errors"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"log"
	"net/http"
	"os"
	"testing"
	"time"
)

func main() {

	log.Println("Started autoDns.")

	c := &config{
		"https://api.ipify.org?format=json",
		120,
		os.Getenv("zone_name"),
		os.Getenv("a_record"),
	}

	for true {

		log.Println("starting check")
		err := checkAndApply(c)
		log.Println("finished check")
		if err != nil {
			log.Fatal(err)
		}
		log.Println("Entering wait.")

		time.Sleep(c.refresh * time.Second)

		log.Println("Sleep finished.")

	}

}

func checkAndApply(c *config) (err error) {

	url := c.ip_api
	// Build the request
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return errors.New("ipify: Unable to create new http request.")
	}

	// create a Client
	// A Client is an HTTP client
	client := &http.Client{}

	// For control over HTTP client headers,
	// redirect policy, and other settings,

	// Send the request via a client
	// Do sends an HTTP request and
	// returns an HTTP response
	resp, err := client.Do(req)
	if err != nil {
		return errors.New("Error sending HTTP request.")
	}

	// Callers should close resp.Body
	// when done reading from it
	// Defer the closing of the body
	defer resp.Body.Close()

	// Fill the record with the data from the JSON
	ip := &ipaddress{}
	// Use json.Decode for reading streams of JSON data
	if err := json.NewDecoder(resp.Body).Decode(&ip); err != nil {
		return errors.New("Error decoding response.")
	}

	if ip.IP == "" || resp.StatusCode != 200 {
		return errors.New("ipify returned an invalid IP address or response")
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: os.Getenv("tfDir"),

		Vars: map[string]interface{}{
			"public_ip_address": ip.IP,
			"zone_name":         c.zone_name,
			"a_record":          c.a_record,
		},

		NoColor: true,
	}

	t := &testing.T{}

	_, err = terraform.InitAndApplyE(t, terraformOptions)
	if err != nil {
		return errors.New("Terraform init/apply failed.")
	}
	return nil
}

type ipaddress struct {
	IP string `json:"ip"`
}

type config struct {
	ip_api	string
	refresh time.Duration
	zone_name string
	a_record string
}
