package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

func triggerWorkflow(token, owner, repo, workflowName, imageTag, imageName string) {
	url := fmt.Sprintf("https://api.github.com/repos/%s/%s/dispatches", owner, repo)

	headers := map[string]string{
		"Accept":        "application/vnd.github.v3+json",
		"Authorization": "token " + token,
	}

	payload := map[string]interface{}{
		"event_type": workflowName,
		"client_payload": map[string]interface{}{
			"imageTag":  imageTag,
			"imageName": imageName,
		},
	}

	jsonPayload, err := json.Marshal(payload)
	if err != nil {
		fmt.Println("Error marshalling JSON:", err)
		return
	}

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonPayload))
	if err != nil {
		fmt.Println("Error creating request:", err)
		return
	}

	for key, value := range headers {
		req.Header.Set(key, value)
	}

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println("Error making request:", err)
		return
	}
	defer resp.Body.Close()

	fmt.Println("Response Status:", resp.Status)
}

func main() {
	if len(os.Args) < 7 {
		fmt.Println("Usage: go run main.go <TOKEN> <OWNER> <REPO> <Workflow_Name> <ImageTag> <ImageName>")
		return
	}

	token := os.Args[1]
	owner := os.Args[2]
	repo := os.Args[3]
	workflowName := os.Args[4]
	imageTag := os.Args[5]
	imageName := os.Args[6]

	triggerWorkflow(token, owner, repo, workflowName, imageTag, imageName)
}
