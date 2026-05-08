// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/home/home_data.dart';
import 'package:exdock_backoffice/pages/home/home_synchronuous.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<HomeData> getHomeData() async {
    // Mock data
    return HomeData(
      lifetimeSales: 14843573.82,
      averageOrder: 21.92,
      lastOrders: [
        HomeDataOrder(
          customerName: "firstName lastName",
          itemCount: 2,
          totalAmount: 11.53,
        ),
        HomeDataOrder(
          customerName: "firstName lastName",
          itemCount: 2,
          totalAmount: 11.53,
        ),
        HomeDataOrder(
          customerName: "firstName lastName",
          itemCount: 2,
          totalAmount: 11.53,
        ),
        HomeDataOrder(
          customerName: "firstName lastName",
          itemCount: 2,
          totalAmount: 11.53,
        ),
        HomeDataOrder(
          customerName: "firstName lastName",
          itemCount: 2,
          totalAmount: 11.53,
        ),
      ],
      lastSearches: [
        HomeDataSearch(searchTerm: "searchTerm", results: 2, uses: 161),
        HomeDataSearch(searchTerm: "searchTerm", results: 0, uses: 10),
        HomeDataSearch(searchTerm: "searchTerm", results: 2, uses: 76),
        HomeDataSearch(searchTerm: "searchTerm", results: 9, uses: 38),
        HomeDataSearch(searchTerm: "searchTerm", results: 0, uses: 15),
      ],
      topProducts: [
        HomeDataProduct(productName: "productName", price: 11.53),
        HomeDataProduct(productName: "productName", price: 11.53),
        HomeDataProduct(productName: "productName", price: 11.53),
        HomeDataProduct(productName: "productName", price: 11.53),
        HomeDataProduct(productName: "productName", price: 11.53),
      ],
      topSearches: [
        HomeDataSearch(searchTerm: "searchTerm", results: 2, uses: 161),
        HomeDataSearch(searchTerm: "searchTerm", results: 0, uses: 10),
        HomeDataSearch(searchTerm: "searchTerm", results: 2, uses: 76),
        HomeDataSearch(searchTerm: "searchTerm", results: 9, uses: 38),
        HomeDataSearch(searchTerm: "searchTerm", results: 0, uses: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: FutureBuilder(
          future: getHomeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              // TODO: handle error
            }
            return HomeSynchronous(homeData: snapshot.data!);
          }),
    );
  }
}
