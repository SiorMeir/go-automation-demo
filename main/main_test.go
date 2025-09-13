package main

import (
	"net/http"
	"net/http/httptest"
	"strings"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("API Server", func() {
	Context("Hello endpoint", func() {
		It("should return hello world message", func() {
			req, err := http.NewRequest("GET", "/", nil)
			Expect(err).NotTo(HaveOccurred())

			rr := httptest.NewRecorder()
			handler := http.HandlerFunc(helloHandler)

			handler.ServeHTTP(rr, req)

			Expect(rr.Code).To(Equal(http.StatusOK))
			Expect(rr.Header().Get("Content-Type")).To(Equal("application/json"))
			Expect(strings.TrimSpace(rr.Body.String())).To(Equal(`{"message": "Hello, World!"}`))
		})
	})

	Context("Health endpoint", func() {
		It("should return healthy status", func() {
			req, err := http.NewRequest("GET", "/health", nil)
			Expect(err).NotTo(HaveOccurred())

			rr := httptest.NewRecorder()
			handler := http.HandlerFunc(healthHandler)

			handler.ServeHTTP(rr, req)

			Expect(rr.Code).To(Equal(http.StatusOK))
			Expect(rr.Header().Get("Content-Type")).To(Equal("application/json"))
			Expect(strings.TrimSpace(rr.Body.String())).To(Equal(`{"status": "healthy"}`))
		})
	})
})
