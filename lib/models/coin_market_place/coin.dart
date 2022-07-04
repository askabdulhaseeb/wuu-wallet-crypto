import 'dart:convert';
import 'coin_platform.dart';
import 'coin_quote.dart';

class Coin {
  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.numMarketPairs,
    required this.dateAdded,
    required this.tags,
    required this.maxSupply,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.platform,
    required this.cmcRank,
    required this.selfReportedCirculatingSupply,
    required this.selfReportedMarketCap,
    required this.tvlRatio,
    required this.lastUpdated,
    required this.quote,
  });

  int id;
  String name;
  String symbol;
  String slug;
  int numMarketPairs;
  DateTime dateAdded;
  List<String> tags;
  int? maxSupply;
  double circulatingSupply;
  double totalSupply;
  CoinPlatform? platform;
  int? cmcRank;
  double? selfReportedCirculatingSupply;
  double? selfReportedMarketCap;
  double? tvlRatio;
  DateTime lastUpdated;
  CoinQuote quote;

  // ignore: sort_constructors_first
  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        slug: json['slug'],
        numMarketPairs: json['num_market_pairs'],
        dateAdded: DateTime.parse(json['date_added']),
        tags: List<String>.from(json['tags'].map((dynamic x) => x)),
        maxSupply: json['max_supply'],
        circulatingSupply:
            double.parse(json['circulating_supply']?.toString() ?? '0.0'),
        totalSupply: double.parse(json['total_supply']?.toString() ?? '0.0'),
        platform: json['platform'] == null
            ? null
            : CoinPlatform.fromMap(json['platform']),
        cmcRank: json['cmc_rank'],
        selfReportedCirculatingSupply: double.parse(
            json['self_reported_circulating_supply']?.toString() ?? '0.0'),
        selfReportedMarketCap: json['self_reported_market_cap'],
        tvlRatio: json['tvl_ratio'],
        lastUpdated: DateTime.parse(json['last_updated']),
        quote: CoinQuote.fromMap(json['quote']),
      );

  static Coin fromMap(String str) => Coin.fromJson(json.decode(str));
}
