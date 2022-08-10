import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const APP_NAME = "Kryptonia";
const COMPANY_NAME = "Kryptonia Inc";

const ID = "id";
const NAME = "name";
const IMAGE = "image";
const IMAGE_NAME = "image_name";
const SYMBOL = "symbol";
const CURRENT_PRICE = "current_price";
const PRICE_CHANGE_PERCENTAGE_24H = "price_change_percentage_24h";
const SPARKLINE_IN_7D = "sparkline_in_7d";
const SPOTS = "spots";
const PRICE = "price";

const BALANCES = "balances";
const EX_RATES = "exRates";

//! RefBonus in USD (will multiply accordingly with exchange rate);
const REFBONUS = 10.0;

const BITCOIN = "bitcoin";
const ETHEREUM = "ethereum";
const BINANCE = "binancecoin";
const DOGECOIN = "dogecoin";

const BTC = "btc";
const ETH = "eth";
const BNB = "bnb";
const DOGE = "doge";
const USDT = "usdt";

const ERC20 = "erc20";
const WALLETS = "wallets";
const ADDRESS = "address";
const ADDRESSES = "addresses";
const BTCADDRESS = "btcAddress";
const ETHADDRESS = "ethAddress";
const DOGEADDRESS = "dogeAddress";

const TRANSFERKEY = "transfer_key";
const WALLETID = "wallet_id";
const WALLET = "wallet";
const AVAILABLE = "available";
const TOTAL = "total";
const DESTINATIONS = "destinations";
const NOTIFICATION = "notification";
const MESSAGE = "message";
const ITEMS = "items";
const DATE = "date";

const ETH_URL = "https://api.etherscan.io";
const BSC_URL = "https://api.bscscan.com";
const BTC_EXPLORER = "https://www.blockchain.com/btc/tx/";
const ETH_EXPLORER = "https://etherscan.io/tx/";
const BNB_EXPLORER = "https://bscscan.com/tx/";
const DOGE_EXPLORER = "https://dogechain.info/tx/";

const List CRYPTOCURRENCIES = [
  BITCOIN,
  ETHEREUM,
  BINANCE,
  DOGECOIN,
];
const List UNITS = [
  BTC,
  ETH,
  BNB,
  DOGE,
];

const List ERC20LIST = [
  ETH,
  BNB,
];

const USD = "usd";
const EUR = "eur";
const RUB = "rub";
const AUD = "aud";
const INR = "inr";
const NGN = "ngn";
const CNY = "cny";
const JPY = "jpy";
const IDR = "idr";

const List CURRENCIES = [
  USD,
  EUR,
  RUB,
  AUD,
  INR,
  NGN,
  CNY,
  JPY,
  IDR,
];

const ENGLISH = "english";
const FRENCH = "french";
const JAPANESE = "japanese";
const CHINESE = "chinese";
const HINDI = "hindi";
const RUSSIAN = "russian";
const KOREAN = "korean";
const BELGIUM = "belgium";
const GERMAN = "german";
const SPANISH = "spanish";
const PORTUGUESE = "portuguese";
const INDONESIAN = "indonesian";
const ARABIC = "arabic";

const List<String> LANGUAGE_CODES = [
  'ar',
  'de',
  'en',
  'es',
  'fr',
  'hi',
  'id',
  'ja',
  'ko',
  'nl',
  'pt',
  'ru',
  'zh',
];

const List<String?> LANGUAGES = [
  ARABIC,
  GERMAN,
  ENGLISH,
  SPANISH,
  FRENCH,
  HINDI,
  INDONESIAN,
  JAPANESE,
  KOREAN,
  BELGIUM,
  PORTUGUESE,
  RUSSIAN,
  CHINESE,
];

const String PAYSTACK = "Paystack";
const String RAZOR_PAY = "RazorPay";
const String PAYPAL = "Paypal";

const List<String> PAYMENT_METHODS = [
  PAYSTACK,
  RAZOR_PAY,
  PAYPAL,
  BANK,
];

const Map<String?, Map<String?, String?>> PAYMENT_MAP = {
  PAYSTACK: {
    IMAGE: "assets/images/paystack.png",
  },
  RAZOR_PAY: {
    IMAGE: "assets/images/razorpay.png",
  },
  PAYPAL: {
    IMAGE: "assets/images/paypal.png",
  },
  BANK: {
    IMAGE: "assets/images/bank.png",
  },
};

const List<String> PAYOUT_METHODS = [
  BANK,
  PAYPAL,
  PAYONEER,
];

const Map<String?, Map<String?, String?>> PAYOUT_MAP = {
  BANK: {
    IMAGE: "assets/images/bank.png",
  },
  PAYPAL: {
    IMAGE: "assets/images/paypal.png",
  },
  PAYONEER: {
    IMAGE: "assets/images/payoneer.png",
  },
};

const List ACTIVITY_MAP = [
  {
    TYPE: 0,
    ACTIVITY: LOGIN,
    MESSAGE: 'New Login to account',
  },
  {
    TYPE: 1,
    ACTIVITY: REGISTER,
    MESSAGE: 'Registered an account',
  },
  {
    TYPE: 2,
    ACTIVITY: FORGET_PASS,
    MESSAGE: 'Requested a password reset',
  },
  {
    TYPE: 3,
    ACTIVITY: CHANGE_PASS,
    MESSAGE: 'Changed your password',
  },
  {
    TYPE: 4,
    ACTIVITY: SWAP,
    MESSAGE: 'Swapped some coins',
  },
  {
    TYPE: 5,
    ACTIVITY: BUY,
    MESSAGE: 'Purchased some coins',
  },
  {
    TYPE: 6,
    ACTIVITY: SELL,
    MESSAGE: 'Sold some coins',
  },
  {
    TYPE: 7,
    ACTIVITY: SEND,
    MESSAGE: 'Sent some coins',
  },
  {
    TYPE: 8,
    ACTIVITY: RECEIVE,
    MESSAGE: 'Received some coins',
  },
  {
    TYPE: 9,
    ACTIVITY: DISABLE,
    MESSAGE: 'You have disabled your account',
  },
  {
    TYPE: 10,
    ACTIVITY: ENABLE,
    MESSAGE: 'You have enabled your account',
  },
  {
    TYPE: 11,
    ACTIVITY: UPDATE,
    MESSAGE: 'You have updated your account',
  },
  {
    TYPE: 12,
    ACTIVITY: REQUEST,
    MESSAGE: 'You have requested for referral payout',
  },
];

List<FlSpot> defaultSpark = [
  FlSpot(1.0, 46472.897998044195),
  FlSpot(2.0, 46662.46215816087),
  FlSpot(3.0, 47028.076433708644),
  FlSpot(4.0, 47121.06246521769),
  FlSpot(5.0, 47084.74403976415),
  FlSpot(6.0, 47299.9215486446),
  FlSpot(7.0, 46965.17806527827),
  FlSpot(8.0, 46704.30601005894),
  FlSpot(9.0, 46738.78980221296),
  FlSpot(10.0, 46421.951512502914),
  FlSpot(11.0, 46558.6155768435),
  FlSpot(12.0, 46632.204099543065),
  FlSpot(13.0, 46514.6448955016),
  FlSpot(14.0, 46806.57355652654),
  FlSpot(15.0, 47128.00342748428),
  FlSpot(16.0, 46869.31500189539),
  FlSpot(17.0, 46783.178748500046),
  FlSpot(18.0, 46807.18639553805),
  FlSpot(19.0, 46881.53103760189),
  FlSpot(20.0, 46581.248266822884),
  FlSpot(21.0, 46382.55602736656),
];

const PASSPORT = "passport";
const DRIVERS_LICENSE = "drivers_license";
const NATIONAL_ID = "national_id";
const ID_TYPE = "id_type";
const ID_NO = "id_no";

const List<String> TYPE_ID = [
  PASSPORT,
  DRIVERS_LICENSE,
  NATIONAL_ID,
];

const AMOUNT = "amount";
const ADMIN_AMOUNT = "admin_amount";
const TOKEN = "token";
const CONTRACTADD = "contractAddress";
const TYPE = "type";
const INCOME = "income";
const TITLE = "title";
const BODY = "body";
const UNIT = "unit";
const VALUE = "value";
const TIMESTAMP = "timeStamp";
const EXPIRES_AT = "expires_at";
const CREATED_AT = "created_at";
const UPDATED_AT = "updated_at";
const TRXN_HASH = "payin_hash";
const CODE = "code";
const EMAIL_OTP = "otp";
const OTPS = "otps";
const REFERENCE = "reference";
const TO_GET = "to_get";
const PAYMENTID = "actually_paid";
const AMOUNT_PAID = "payment_id";
const PAYMENT_STATUS = "payment_status";
const PAYMENT_METHOD = "payment_method";
const STATUS = "status";
const TO = "to";
const FROM = "from";
const DATA = "data";
const GAS_FEE = "gasFee";
const HASH = "hash";
const RESULT = "result";
const BOUGHT = "bought";
const SOLD = "sold";
const PRICING = "pricing";

const TRANSACTIONS = "transactions";
const ACTIVITY = "activity";
const ACTIVITIES = "activities";
const DEVICE_ACTIVITIES = "deviceActivities";

const LOGIN = 'login';
const REGISTER = 'register';
const UPDATE = 'update';
const DELETE = 'delete';
const DISABLE = 'disable';
const ENABLE = 'enable';
const FORGET_PASS = 'forget password';
const CHANGE_PASS = 'change password';
const SWAP = 'swap';
const BUY = 'buy';
const SELL = 'sell';
const SEND = 'send';
const RECEIVE = 'receive';
const REQUEST = "request";

const CATEGORY = "category";
const DATETIME = "datetime";
const HEADLINE = "headline";
const SOURCE = "source";
const URL = "url";
const SUMMARY = "summary";

const ALL_CRYPTO_DATAS = "allcCryptoDatas";
const CRYPTO_DATAS = "cryptoDatas";
const ALL_COINS_LIST = "allCoinsList";
const MAX_MIN_LIST = "maxMinList";
const MIN_LIST = "minList";

String? infura = dotenv.env['INFURA_PROJECT_ID'];

String eTHRPCURL = 'https://mainnet.infura.io/v3/$infura';
const BSC_RPC_URL = "https://bsc-dataseed.binance.org/";
const BSC_TEST_RPC_URL = "https://data-seed-prebsc-1-s1.binance.org:8545/";

const USERS = "users";
const ADMINS = "admins";

const UID = "uid";
const USER = "user";
const FIRST_NAME = "firstName";
const LAST_NAME = "lastName";
const EMAIL = "email";
const PASSWORD = "password";
const NEW_PASSWORD = "newPassword";
const PROFILEPIC = "profilePic";
const COUNTRY = "country";
const CITY = "city";
const STATE = "state";
const COUNTRIES = "countries";
const PHONE = "phone";
const REFBALANCE = "refBalance";
const DATECREATED = "dateCreated";
const DOB = "dob";
const TWOFA = "twoFa";
const REFERREDBY = "referredBy";
const REFCODE = "refCode";
const REFCONFIRMCOUNT = "refConfirmCount";
const REFUNCONFIRMCOUNT = "refUnconfirmCount";
const CONFI = "confi";
const REFERCOUNT = "referCount";
const ISADMIN = "isAdmin";
const BLOCKED = "blocked";
const DISABLED = "disabled";
const DISABLE_END_DATE = "disableEndDate";
const VERIFIED = "verified";
const SESSION_END = "session_end";
const IDENTIFIED = "identified";
const UNVERIFIED = "unverified";

// Bank
const FINANCIAL = "financial";

const BANK = "bank";
const BANKNAME = "bankName";
const BANKCOUNTRY = "bankCountry";
const BANKSORTCODE = "bankSortCode";
const ACCOUNTNUMBER = "accNum";
const ACCOUNTNAME = "accName";

//PayPal
const PAYPALEMAIL = "payPalEmail";

//Payoneer
const PAYONEER = "payoneer";
const PAYONEERBANKNAME = "payoneerBankName";
const PAYONEERBANKCOUNTRY = "payoneerBankCountry";
const PAYONEERROUTINGBANKSORTCODE = "payoneerRoutingBankSortCode";
const PAYONEERACCOUNTNUMBER = "payoneerAccNum";
const PAYONEERACCOUNTTYPE = "payoneerAccType";
const PAYONEERBENEFICIARYNAME = "payoneerBenficiaryName";

const COMPLETED = "completed";
const PENDING = "pending";
const FAILED = "failed";
const SUCCESS = "success";

const CONFIRMED = "confirmed";
const UNCONFIRMED = "unConfirmed";

const DEVICENAME = "deviceName";
const IP = "ip";
const LOCATION = "location";

const SETTINGS = "settings";
const THEME = "theme";
const PASSCODE = "passcode";
const BIOMETRICS = "biometrics";
const APP_LOCK = "appLock";
const HAS_2FA = "has_2fa";
const PRIVACY_MODE = "privacy";
const TRXN_SIGNING = "trxn";
const LANGUAGE = "language";
const CURRENCY = "currency";
const RATE = "rate";
const DEFAULT_ERROR = "Something went wrong";

const HEXCHARS = "abcdef0123456789";

String hexString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += HEXCHARS[rnd.nextInt(HEXCHARS.length)];
  }
  return result;
}

const CHARS = "abcdefghijklmnopqrstuvwxyz0123456789";

const EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String randomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += CHARS[rnd.nextInt(CHARS.length)];
  }
  return result;
}

extension StringExtension on String? {
  String? capitalize() {
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }
}

const FACE = "Face";
const TOUCHID = "TouchId";
const VERSION = "version";

const FLASHON = "flashOn";
const FRONTCAMERA = "frontCamera";
const FLASHOFF = "flashOff";
const BACKCAMERA = "backCamera";

const GOOGLE = "google";
const FACEBOOK = "Facebook";
const INSTAGRAM = "Instagram";
const TWITTER = "Twitter";
const TELEGRAM = "Telegram";
const REDDIT = "Reddit";
const YOUTUBE = "Youtube";
const MEDIUM = "Medium";
