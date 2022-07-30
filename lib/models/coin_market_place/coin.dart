import 'dart:convert';

class Coin {
  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.totalVolume,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.priceChangePercentage7D,
    required this.priceChangePercentage14D,
    required this.priceChangePercentage30D,
    required this.priceChangePercentage60D,
    required this.priceChangePercentage200D,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int totalVolume;
  final double priceChange24H;
  final double priceChangePercentage24H;
  final double priceChangePercentage7D;
  final double priceChangePercentage14D;
  final double priceChangePercentage30D;
  final double priceChangePercentage60D;
  final double priceChangePercentage200D;

  // ignore: sort_constructors_first
  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'] + 0.0,
      totalVolume: json['total_volume'],
      priceChange24H: json['price_change_24h'] + 0.0,
      priceChangePercentage24H: json['price_change_percentage_24h'] + 0.0,
      priceChangePercentage7D: json['price_change_percentage_7d'] + 0.0,
      priceChangePercentage14D: json['price_change_percentage_14d'] + 0.0,
      priceChangePercentage30D: json['price_change_percentage_30d'] + 0.0,
      priceChangePercentage60D: json['price_change_percentage_60d'] + 0.0,
      priceChangePercentage200D: json['price_change_percentage_200d'] + 0.0,
    );
  }

  static Coin fromMap(String str) => Coin.fromJson(json.decode(str));
}
