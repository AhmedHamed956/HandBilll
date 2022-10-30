import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/account/agent_response.dart';

class HelpRepository {
  String tag = "HelpsRepository";
  Dio _dio = Dio();

  Future<AgentResponse> getAgentData() async {
    Map<String, String> queryParams = ({"secret": APIData.secretKey});

    late AgentResponse agentResponse;
    Response response;
    try {
      response =
          await _dio.get(APIData.getAllAgent, queryParameters: queryParams);

      agentResponse = AgentResponse.fromJson(response.data);
      if (agentResponse.status!) {
        return agentResponse;
      } else {
        return agentResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return agentResponse;
  }
}
