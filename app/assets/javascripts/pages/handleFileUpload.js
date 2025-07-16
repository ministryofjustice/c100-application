async function handleFileUpload(input) {
    const form = input.closest("form");
    const formData = new FormData(form);

    try {
        const response = await fetch(form.action, {
            method: "POST",
            body: formData,
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            }
        });

        if (!response.ok) {
            alert("Upload failed");
            return;
        }

        const html = await response.text();
        console.log("AJAX response HTML:", html);

        const container = document.querySelector("#uploaded-documents-container");
        console.log("Found container:", container);

        if (!container) {
            console.warn("Container #uploaded-documents-container not found.");
            return;
        }

        // Parse the response HTML to check if it includes the container div itself
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, "text/html");
        const newContainer = doc.querySelector("#uploaded-documents-container");
        console.log("Parsed new container from response:", newContainer);

        if (newContainer) {
            // If response has full container div, replace existing container element
            container.replaceWith(newContainer);
            console.log("Container replaced with new content.");
        } else {
            // If response is just inner content, replace innerHTML only
            container.innerHTML = html;
            console.log("Container innerHTML replaced with response HTML.");
        }

    } catch (error) {
        console.error("Error during file upload:", error);
        alert("Upload failed due to an error.");
    }
}
