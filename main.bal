import ballerina/ai;
import ballerina/http;

listener ai:Listener webFetchListener = new (listenOn = check http:getDefaultListener());

service /webFetch on webFetchListener {
    private final ai:Agent webFetchAgent;

    function init() returns error? {
        self.webFetchAgent = check new (
            systemPrompt = {role: string `Web Content Summarizer`, instructions: string `Summarize the retrieved content. Produce a single, concise summary in clear, neutral language and then end the response.`}, model = webFetchModel, tools = [fetchTool], verbose = false
        );
    }

    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check self.webFetchAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
