import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {

  //instancia do logger
  Logger logger = Logger();


  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v("Request to: ${data.baseUrl}\nHeader: ${data.headers}\nBody: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {

    //mostrar em vermelho em caso de erro
    if(data.statusCode ~/100 == 2){
      logger.i("Response from: ${data.url}\n"
          "Response Status: ${data.statusCode}\n"
          "Header: ${data.headers}\n"
          "Body: ${data.body}");
    }else {
      logger.e("Response from: ${data.url}\n"
          "Response Status: ${data.statusCode}\n"
          "Header: ${data.headers}\n"
          "Body: ${data.body}");    }
    return data;
  }

}