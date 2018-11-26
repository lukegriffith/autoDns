package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func main() {

	url := "https://api.ipify.org?format=json"

	// Build the request
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Fatal("NewRequest: ", err)
		return
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
		log.Fatal("Do: ", err)
		return
	}

	// Callers should close resp.Body
	// when done reading from it
	// Defer the closing of the body
	defer resp.Body.Close()

	// Fill the record with the data from the JSON
	ip := &ipaddress{}

	// Use json.Decode for reading streams of JSON data
	if err := json.NewDecoder(resp.Body).Decode(&ip); err != nil {
		log.Println(err)
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: os.Getenv("tfDir"),

		Vars: map[string]interface{}{
			"public_ip_address": ip.IP,
		},

		NoColor: true,
	}

	t := &testing.T{}

	terraform.InitAndApply(t, terraformOptions)

}

type ipaddress struct {
	IP string `json:"ip"`
}
