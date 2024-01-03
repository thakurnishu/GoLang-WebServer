package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestFormHandler(t *testing.T) {
	// Create a request with form values
	req, err := http.NewRequest("POST", "/form", strings.NewReader("name=John&address=123 Main St"))
	if err != nil {
		t.Fatal(err)
	}
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	// Create a response recorder to capture the response
	rr := httptest.NewRecorder()

	// Call the formHandler with the test request and response recorder
	formHandler(rr, req)

	// Check the HTTP status code
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("Handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	// Check the response body
	expected := "POST request succesful\nName =John\nAddress= 123 Main St\n"
	if rr.Body.String() != expected {
		t.Errorf("Handler returned unexpected body: got %v want %v", rr.Body.String(), expected)
	}
}

func TestHelloHandler(t *testing.T) {
	// Create a request for the /hello endpoint
	req, err := http.NewRequest("GET", "/hello", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Create a response recorder to capture the response
	rr := httptest.NewRecorder()

	// Call the helloHandler with the test request and response recorder
	helloHandler(rr, req)

	// Check the HTTP status code
	if status := rr.Code; status != http.StatusOK {
		t.Errorf("Handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	// Check the response body
	expected := "Hello !\n"
	if rr.Body.String() != expected {
		t.Errorf("Handler returned unexpected body: got %v want %v", rr.Body.String(), expected)
	}
}

