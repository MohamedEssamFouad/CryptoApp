import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../model/data.dart';
class CoinController extends GetxController{
  RxList<Welcome>coinList=<Welcome>[].obs;
  RxBool isload=true.obs;
  onInit(){
    super.onInit();
    fetchCoins();
  }

  fetchCoins() async {
    try {
      var response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en'));

      if (response.statusCode == 200) {
        List<Welcome> coins = welcomeFromJson(response.body);
        coinList.value = coins;
        isload.value = false; // Data is successfully loaded
      } else {
        isload.value = true; // Data loading failed
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      isload.value = false; // Data loading failed
      print("Error fetching data: $e");
    }
  }

}