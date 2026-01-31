import ballerina/ai;

final ai:Wso2ModelProvider webFetchModel = check ai:getDefaultModelProvider();

final FetchToolToolkit fetchTool = check new (string `https://remote.mcpservers.org/fetch/mcp
`, validation = false, laxDataBinding = false);
