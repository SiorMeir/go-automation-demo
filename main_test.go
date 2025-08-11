package main

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"
)

func TestHealthHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/health", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(healthHandler)

	handler.ServeHTTP(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	var response HealthResponse
	if err := json.Unmarshal(rr.Body.Bytes(), &response); err != nil {
		t.Errorf("failed to unmarshal response: %v", err)
	}

	if response.Status != "healthy" {
		t.Errorf("handler returned unexpected status: got %v want %v", response.Status, "healthy")
	}

	if response.Timestamp.IsZero() {
		t.Error("handler returned zero timestamp")
	}
}

func TestDataHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/data", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(dataHandler)

	handler.ServeHTTP(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	var response DataResponse
	if err := json.Unmarshal(rr.Body.Bytes(), &response); err != nil {
		t.Errorf("failed to unmarshal response: %v", err)
	}

	if response.Message != "Data loaded successfully" {
		t.Errorf("handler returned unexpected message: got %v want %v", response.Message, "Data loaded successfully")
	}

	if response.Data == nil {
		t.Error("handler returned nil data")
	}
}

func TestVersionHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/version", nil)
	if err != nil {
		t.Fatal(err)
	}

	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(versionHandler)

	handler.ServeHTTP(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusOK)
	}

	var response VersionResponse
	if err := json.Unmarshal(rr.Body.Bytes(), &response); err != nil {
		t.Errorf("failed to unmarshal response: %v", err)
	}

	if response.Version != "1.0.0" {
		t.Errorf("handler returned unexpected version: got %v want %v", response.Version, "1.0.0")
	}

	if response.BuildTime == "" {
		t.Error("handler returned empty build time")
	}

	if response.GitCommit != "development" {
		t.Errorf("handler returned unexpected git commit: got %v want %v", response.GitCommit, "development")
	}
}

func TestMethodNotAllowed(t *testing.T) {
	methods := []string{"POST", "PUT", "DELETE", "PATCH"}

	for _, method := range methods {
		t.Run(method, func(t *testing.T) {
			req, err := http.NewRequest(method, "/health", nil)
			if err != nil {
				t.Fatal(err)
			}

			rr := httptest.NewRecorder()
			handler := http.HandlerFunc(healthHandler)

			handler.ServeHTTP(rr, req)

			if status := rr.Code; status != http.StatusMethodNotAllowed {
				t.Errorf("handler returned wrong status code for %s: got %v want %v", method, status, http.StatusMethodNotAllowed)
			}
		})
	}
}

func TestLoadData(t *testing.T) {
	data, err := loadData()
	if err != nil {
		t.Fatalf("loadData failed: %v", err)
	}

	if data == nil {
		t.Error("loadData returned nil data")
	}

	// Verify the data structure
	dataMap, ok := data.(map[string]interface{})
	if !ok {
		t.Error("loadData returned data that is not a map")
	}

	// Check if features exist
	if features, exists := dataMap["features"]; !exists {
		t.Error("data does not contain features")
	} else {
		featuresSlice, ok := features.([]interface{})
		if !ok {
			t.Error("features is not a slice")
		}
		if len(featuresSlice) == 0 {
			t.Error("features slice is empty")
		}
	}

	// Check if stats exist
	if stats, exists := dataMap["stats"]; !exists {
		t.Error("data does not contain stats")
	} else {
		if stats == nil {
			t.Error("stats is nil")
		}
	}
}

func TestLoadDataFileNotFound(t *testing.T) {
	// Temporarily rename data.json to test file not found
	originalName := "data.json"
	tempName := "data.json.tmp"

	if err := os.Rename(originalName, tempName); err != nil {
		t.Skipf("Cannot rename file for test: %v", err)
	}
	defer os.Rename(tempName, originalName)

	_, err := loadData()
	if err == nil {
		t.Error("loadData should fail when data.json is missing")
	}
}
