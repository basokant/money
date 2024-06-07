import gleam/string
import gleam/float
import gleam/int
import gleam/result

pub type Currency {
  ISOCurrency(name: String, code: ISOCurrencyCode, units: Int)
  CustomCurrency(name: String, code: CustomCurrencyCode, units: Int)
}

pub type CustomCurrencyCode {
  CustomCurrencyCode(code: String)
}

pub type CurrencyError {
  CurrencyCodesNotEqual
  CurrencyUnitsNotEqual
  CurrenciesNotEqual
}

pub fn check_currencies(a: Currency, b: Currency) -> Result(Nil, CurrencyError) {
  let are_codes_equal = case a, b {
    ISOCurrency(_, code_a, _), ISOCurrency(_, code_b, _) -> code_a == code_b
    CustomCurrency(_, code_a, _), CustomCurrency(_, code_b, _) ->
      code_a == code_b
    _, _ -> False
  }

  let are_units_equal = a.units == b.units

  case are_codes_equal, are_units_equal {
    True, True -> Ok(Nil)
    False, True -> Error(CurrencyCodesNotEqual)
    True, False -> Error(CurrencyUnitsNotEqual)
    False, False -> Error(CurrenciesNotEqual)
  }
}

pub fn code_to_string(currency: Currency) -> String {
  case currency {
    ISOCurrency(_, code, _) -> iso_code_to_string(code)
    CustomCurrency(_, code, _) -> code.code
  }
}

pub fn get_unit_factor(currency: Currency) -> Int {
  let exponent = int.to_float(currency.units)

  int.power(10, exponent)
  |> result.unwrap(0.0)
  |> float.round()
}

pub fn to_string(currency: Currency) -> String {
  let code_string = code_to_string(currency)
  string.join(
    [
      "code:",
      code_string,
      "name:",
      currency.name,
      "units:",
      int.to_string(currency.units),
    ],
    " ",
  )
}

pub fn from_code(code: ISOCurrencyCode) -> Currency {
  case code {
    AFN -> ISOCurrency(name: "Afghani", code: AFN, units: 2)
    EUR -> ISOCurrency(name: "Euro", code: EUR, units: 2)
    ALL -> ISOCurrency(name: "Lek", code: ALL, units: 2)
    DZD -> ISOCurrency(name: "Algerian Dinar", code: DZD, units: 2)
    USD -> ISOCurrency(name: "US Dollar", code: USD, units: 2)
    AOA -> ISOCurrency(name: "Kwanza", code: AOA, units: 2)
    XCD -> ISOCurrency(name: "East Caribbean Dollar", code: XCD, units: 2)
    ARS -> ISOCurrency(name: "Argentine Peso", code: ARS, units: 2)
    AMD -> ISOCurrency(name: "Armenian Dram", code: AMD, units: 2)
    AWG -> ISOCurrency(name: "Aruban Florin", code: AWG, units: 2)
    AUD -> ISOCurrency(name: "Australian Dollar", code: AUD, units: 2)
    AZN -> ISOCurrency(name: "Azerbaijan Manat", code: AZN, units: 2)
    BSD -> ISOCurrency(name: "Bahamian Dollar", code: BSD, units: 2)
    BHD -> ISOCurrency(name: "Bahraini Dinar", code: BHD, units: 3)
    BDT -> ISOCurrency(name: "Taka", code: BDT, units: 2)
    BBD -> ISOCurrency(name: "Barbados Dollar", code: BBD, units: 2)
    BYN -> ISOCurrency(name: "Belarusian Ruble", code: BYN, units: 2)
    BZD -> ISOCurrency(name: "Belize Dollar", code: BZD, units: 2)
    XOF -> ISOCurrency(name: "CFA Franc BCEAO", code: XOF, units: 0)
    BMD -> ISOCurrency(name: "Bermudian Dollar", code: BMD, units: 2)
    INR -> ISOCurrency(name: "Indian Rupee", code: INR, units: 2)
    BTN -> ISOCurrency(name: "Ngultrum", code: BTN, units: 2)
    BOB -> ISOCurrency(name: "Boliviano", code: BOB, units: 2)
    BOV -> ISOCurrency(name: "Mvdol", code: BOV, units: 2)
    BAM -> ISOCurrency(name: "Convertible Mark", code: BAM, units: 2)
    BWP -> ISOCurrency(name: "Pula", code: BWP, units: 2)
    NOK -> ISOCurrency(name: "Norwegian Krone", code: NOK, units: 2)
    BRL -> ISOCurrency(name: "Brazilian Real", code: BRL, units: 2)
    BND -> ISOCurrency(name: "Brunei Dollar", code: BND, units: 2)
    BGN -> ISOCurrency(name: "Bulgarian Lev", code: BGN, units: 2)
    BIF -> ISOCurrency(name: "Burundi Franc", code: BIF, units: 0)
    CVE -> ISOCurrency(name: "Cabo Verde Escudo", code: CVE, units: 2)
    KHR -> ISOCurrency(name: "Riel", code: KHR, units: 2)
    XAF -> ISOCurrency(name: "CFA Franc BEAC", code: XAF, units: 0)
    CAD -> ISOCurrency(name: "Canadian Dollar", code: CAD, units: 2)
    KYD -> ISOCurrency(name: "Cayman Islands Dollar", code: KYD, units: 2)
    CLP -> ISOCurrency(name: "Chilean Peso", code: CLP, units: 0)
    CLF -> ISOCurrency(name: "Unidad de Fomento", code: CLF, units: 4)
    CNY -> ISOCurrency(name: "Yuan Renminbi", code: CNY, units: 2)
    COP -> ISOCurrency(name: "Colombian Peso", code: COP, units: 2)
    COU -> ISOCurrency(name: "Unidad de Valor Real", code: COU, units: 2)
    KMF -> ISOCurrency(name: "Comorian Franc", code: KMF, units: 0)
    CDF -> ISOCurrency(name: "Congolese Franc", code: CDF, units: 2)
    NZD -> ISOCurrency(name: "New Zealand Dollar", code: NZD, units: 2)
    CRC -> ISOCurrency(name: "Costa Rican Colon", code: CRC, units: 2)
    HRK -> ISOCurrency(name: "Kuna", code: HRK, units: 2)
    CUP -> ISOCurrency(name: "Cuban Peso", code: CUP, units: 2)
    CUC -> ISOCurrency(name: "Peso Convertible", code: CUC, units: 2)
    ANG ->
      ISOCurrency(name: "Netherlands Antillean Guilder", code: ANG, units: 2)
    CZK -> ISOCurrency(name: "Czech Koruna", code: CZK, units: 2)
    DKK -> ISOCurrency(name: "Danish Krone", code: DKK, units: 2)
    DJF -> ISOCurrency(name: "Djibouti Franc", code: DJF, units: 0)
    DOP -> ISOCurrency(name: "Dominican Peso", code: DOP, units: 2)
    EGP -> ISOCurrency(name: "Egyptian Pound", code: EGP, units: 2)
    SVC -> ISOCurrency(name: "El Salvador Colon", code: SVC, units: 2)
    ERN -> ISOCurrency(name: "Nakfa", code: ERN, units: 2)
    SZL -> ISOCurrency(name: "Lilangeni", code: SZL, units: 2)
    ETB -> ISOCurrency(name: "Ethiopian Birr", code: ETB, units: 2)
    FKP -> ISOCurrency(name: "Falkland Islands Pound", code: FKP, units: 2)
    FJD -> ISOCurrency(name: "Fiji Dollar", code: FJD, units: 2)
    XPF -> ISOCurrency(name: "CFP Franc", code: XPF, units: 0)
    GMD -> ISOCurrency(name: "Dalasi", code: GMD, units: 2)
    GEL -> ISOCurrency(name: "Lari", code: GEL, units: 2)
    GHS -> ISOCurrency(name: "Ghana Cedi", code: GHS, units: 2)
    GIP -> ISOCurrency(name: "Gibraltar Pound", code: GIP, units: 2)
    GTQ -> ISOCurrency(name: "Quetzal", code: GTQ, units: 2)
    GBP -> ISOCurrency(name: "Pound Sterling", code: GBP, units: 2)
    GNF -> ISOCurrency(name: "Guinean Franc", code: GNF, units: 0)
    GYD -> ISOCurrency(name: "Guyana Dollar", code: GYD, units: 2)
    HTG -> ISOCurrency(name: "Gourde", code: HTG, units: 2)
    HNL -> ISOCurrency(name: "Lempira", code: HNL, units: 2)
    HKD -> ISOCurrency(name: "Hong Kong Dollar", code: HKD, units: 2)
    HUF -> ISOCurrency(name: "Forint", code: HUF, units: 2)
    ISK -> ISOCurrency(name: "Iceland Krona", code: ISK, units: 0)
    IDR -> ISOCurrency(name: "Rupiah", code: IDR, units: 2)
    XDR -> ISOCurrency(name: "SDR (Special Drawing Right)", code: XDR, units: 0)
    IRR -> ISOCurrency(name: "Iranian Rial", code: IRR, units: 2)
    IQD -> ISOCurrency(name: "Iraqi Dinar", code: IQD, units: 3)
    ILS -> ISOCurrency(name: "New Israeli Sheqel", code: ILS, units: 2)
    JMD -> ISOCurrency(name: "Jamaican Dollar", code: JMD, units: 2)
    JPY -> ISOCurrency(name: "Yen", code: JPY, units: 0)
    JOD -> ISOCurrency(name: "Jordanian Dinar", code: JOD, units: 3)
    KZT -> ISOCurrency(name: "Tenge", code: KZT, units: 2)
    KES -> ISOCurrency(name: "Kenyan Shilling", code: KES, units: 2)
    KPW -> ISOCurrency(name: "North Korean Won", code: KPW, units: 2)
    KRW -> ISOCurrency(name: "Won", code: KRW, units: 0)
    KWD -> ISOCurrency(name: "Kuwaiti Dinar", code: KWD, units: 3)
    KGS -> ISOCurrency(name: "Som", code: KGS, units: 2)
    LAK -> ISOCurrency(name: "Lao Kip", code: LAK, units: 2)
    LBP -> ISOCurrency(name: "Lebanese Pound", code: LBP, units: 2)
    LSL -> ISOCurrency(name: "Loti", code: LSL, units: 2)
    ZAR -> ISOCurrency(name: "Rand", code: ZAR, units: 2)
    LRD -> ISOCurrency(name: "Liberian Dollar", code: LRD, units: 2)
    LYD -> ISOCurrency(name: "Libyan Dinar", code: LYD, units: 3)
    CHF -> ISOCurrency(name: "Swiss Franc", code: CHF, units: 2)
    MOP -> ISOCurrency(name: "Pataca", code: MOP, units: 2)
    MKD -> ISOCurrency(name: "Denar", code: MKD, units: 2)
    MGA -> ISOCurrency(name: "Malagasy Ariary", code: MGA, units: 2)
    MWK -> ISOCurrency(name: "Malawi Kwacha", code: MWK, units: 2)
    MYR -> ISOCurrency(name: "Malaysian Ringgit", code: MYR, units: 2)
    MVR -> ISOCurrency(name: "Rufiyaa", code: MVR, units: 2)
    MRU -> ISOCurrency(name: "Ouguiya", code: MRU, units: 2)
    MUR -> ISOCurrency(name: "Mauritius Rupee", code: MUR, units: 2)
    XUA -> ISOCurrency(name: "ADB Unit of Account", code: XUA, units: 0)
    MXN -> ISOCurrency(name: "Mexican Peso", code: MXN, units: 2)
    MXV ->
      ISOCurrency(
        name: "Mexican Unidad de Inversion (UDI)",
        code: MXV,
        units: 2,
      )
    MDL -> ISOCurrency(name: "Moldovan Leu", code: MDL, units: 2)
    MNT -> ISOCurrency(name: "Tugrik", code: MNT, units: 2)
    MAD -> ISOCurrency(name: "Moroccan Dirham", code: MAD, units: 2)
    MZN -> ISOCurrency(name: "Mozambique Metical", code: MZN, units: 2)
    MMK -> ISOCurrency(name: "Kyat", code: MMK, units: 2)
    NAD -> ISOCurrency(name: "Namibia Dollar", code: NAD, units: 2)
    NPR -> ISOCurrency(name: "Nepalese Rupee", code: NPR, units: 2)
    NIO -> ISOCurrency(name: "Cordoba Oro", code: NIO, units: 2)
    NGN -> ISOCurrency(name: "Naira", code: NGN, units: 2)
    OMR -> ISOCurrency(name: "Rial Omani", code: OMR, units: 3)
    PKR -> ISOCurrency(name: "Pakistan Rupee", code: PKR, units: 2)
    PAB -> ISOCurrency(name: "Balboa", code: PAB, units: 2)
    PGK -> ISOCurrency(name: "Kina", code: PGK, units: 2)
    PYG -> ISOCurrency(name: "Guarani", code: PYG, units: 0)
    PEN -> ISOCurrency(name: "Sol", code: PEN, units: 2)
    PHP -> ISOCurrency(name: "Philippine Peso", code: PHP, units: 2)
    PLN -> ISOCurrency(name: "Zloty", code: PLN, units: 2)
    QAR -> ISOCurrency(name: "Qatari Rial", code: QAR, units: 2)
    RON -> ISOCurrency(name: "Romanian Leu", code: RON, units: 2)
    RUB -> ISOCurrency(name: "Russian Ruble", code: RUB, units: 2)
    RWF -> ISOCurrency(name: "Rwanda Franc", code: RWF, units: 0)
    SHP -> ISOCurrency(name: "Saint Helena Pound", code: SHP, units: 2)
    WST -> ISOCurrency(name: "Tala", code: WST, units: 2)
    STN -> ISOCurrency(name: "Dobra", code: STN, units: 2)
    SAR -> ISOCurrency(name: "Saudi Riyal", code: SAR, units: 2)
    RSD -> ISOCurrency(name: "Serbian Dinar", code: RSD, units: 2)
    SCR -> ISOCurrency(name: "Seychelles Rupee", code: SCR, units: 2)
    SLL -> ISOCurrency(name: "Leone", code: SLL, units: 2)
    SGD -> ISOCurrency(name: "Singapore Dollar", code: SGD, units: 2)
    XSU -> ISOCurrency(name: "Sucre", code: XSU, units: 0)
    SBD -> ISOCurrency(name: "Solomon Islands Dollar", code: SBD, units: 2)
    SOS -> ISOCurrency(name: "Somali Shilling", code: SOS, units: 2)
    SSP -> ISOCurrency(name: "South Sudanese Pound", code: SSP, units: 2)
    LKR -> ISOCurrency(name: "Sri Lanka Rupee", code: LKR, units: 2)
    SDG -> ISOCurrency(name: "Sudanese Pound", code: SDG, units: 2)
    SRD -> ISOCurrency(name: "Surinam Dollar", code: SRD, units: 2)
    SEK -> ISOCurrency(name: "Swedish Krona", code: SEK, units: 2)
    CHE -> ISOCurrency(name: "WIR Euro", code: CHE, units: 2)
    CHW -> ISOCurrency(name: "WIR Franc", code: CHW, units: 2)
    SYP -> ISOCurrency(name: "Syrian Pound", code: SYP, units: 2)
    TWD -> ISOCurrency(name: "New Taiwan Dollar", code: TWD, units: 2)
    TJS -> ISOCurrency(name: "Somoni", code: TJS, units: 2)
    TZS -> ISOCurrency(name: "Tanzanian Shilling", code: TZS, units: 2)
    THB -> ISOCurrency(name: "Baht", code: THB, units: 2)
    TOP -> ISOCurrency(name: "Pa'anga", code: TOP, units: 2)
    TTD -> ISOCurrency(name: "Trinidad and Tobago Dollar", code: TTD, units: 2)
    TND -> ISOCurrency(name: "Tunisian Dinar", code: TND, units: 3)
    TRY -> ISOCurrency(name: "Turkish Lira", code: TRY, units: 2)
    TMT -> ISOCurrency(name: "Turkmenistan New Manat", code: TMT, units: 2)
    UGX -> ISOCurrency(name: "Uganda Shilling", code: UGX, units: 0)
    UAH -> ISOCurrency(name: "Hryvnia", code: UAH, units: 2)
    AED -> ISOCurrency(name: "UAE Dirham", code: AED, units: 2)
    USN -> ISOCurrency(name: "US Dollar (Next day)", code: USN, units: 2)
    UYU -> ISOCurrency(name: "Peso Uruguayo", code: UYU, units: 2)
    UYI ->
      ISOCurrency(
        name: "Uruguay Peso en Unidades Indexadas (UI)",
        code: UYI,
        units: 0,
      )
    UYW -> ISOCurrency(name: "Unidad Previsional", code: UYW, units: 4)
    UZS -> ISOCurrency(name: "Uzbekistan Sum", code: UZS, units: 2)
    VUV -> ISOCurrency(name: "Vatu", code: VUV, units: 0)
    VES -> ISOCurrency(name: "Bolívar Soberano", code: VES, units: 2)
    VND -> ISOCurrency(name: "Dong", code: VND, units: 0)
    YER -> ISOCurrency(name: "Yemeni Rial", code: YER, units: 2)
    ZMW -> ISOCurrency(name: "Zambian Kwacha", code: ZMW, units: 2)
    ZWL -> ISOCurrency(name: "Zimbabwe Dollar", code: ZWL, units: 2)
    XBA ->
      ISOCurrency(
        name: "Bond Markets Unit European Composite Unit (EURCO)",
        code: XBA,
        units: 0,
      )
    XBB ->
      ISOCurrency(
        name: "Bond Markets Unit European Monetary Unit (E.M.U.-6)",
        code: XBB,
        units: 0,
      )
    XBC ->
      ISOCurrency(
        name: "Bond Markets Unit European Unit of Account 9 (E.U.A.-9)",
        code: XBC,
        units: 0,
      )
    XBD ->
      ISOCurrency(
        name: "Bond Markets Unit European Unit of Account 17 (E.U.A.-17)",
        code: XBD,
        units: 0,
      )
    XTS ->
      ISOCurrency(
        name: "Codes specifically eserved or testing purposes",
        code: XTS,
        units: 0,
      )
    XXX ->
      ISOCurrency(
        name: "The codes assigned or ransactions where no currency is involved",
        code: XXX,
        units: 0,
      )
    XAU -> ISOCurrency(name: "Gold", code: XAU, units: 0)
    XPD -> ISOCurrency(name: "Palladium", code: XPD, units: 0)
    XPT -> ISOCurrency(name: "Platinum", code: XPT, units: 0)
    XAG -> ISOCurrency(name: "Silver", code: XAG, units: 0)
  }
}

pub type ISOCurrencyCode {
  AFN
  EUR
  ALL
  DZD
  USD
  AOA
  XCD
  ARS
  AMD
  AWG
  AUD
  AZN
  BSD
  BHD
  BDT
  BBD
  BYN
  BZD
  XOF
  BMD
  INR
  BTN
  BOB
  BOV
  BAM
  BWP
  NOK
  BRL
  BND
  BGN
  BIF
  CVE
  KHR
  XAF
  CAD
  KYD
  CLP
  CLF
  CNY
  COP
  COU
  KMF
  CDF
  NZD
  CRC
  HRK
  CUP
  CUC
  ANG
  CZK
  DKK
  DJF
  DOP
  EGP
  SVC
  ERN
  SZL
  ETB
  FKP
  FJD
  XPF
  GMD
  GEL
  GHS
  GIP
  GTQ
  GBP
  GNF
  GYD
  HTG
  HNL
  HKD
  HUF
  ISK
  IDR
  XDR
  IRR
  IQD
  ILS
  JMD
  JPY
  JOD
  KZT
  KES
  KPW
  KRW
  KWD
  KGS
  LAK
  LBP
  LSL
  ZAR
  LRD
  LYD
  CHF
  MOP
  MKD
  MGA
  MWK
  MYR
  MVR
  MRU
  MUR
  XUA
  MXN
  MXV
  MDL
  MNT
  MAD
  MZN
  MMK
  NAD
  NPR
  NIO
  NGN
  OMR
  PKR
  PAB
  PGK
  PYG
  PEN
  PHP
  PLN
  QAR
  RON
  RUB
  RWF
  SHP
  WST
  STN
  SAR
  RSD
  SCR
  SLL
  SGD
  XSU
  SBD
  SOS
  SSP
  LKR
  SDG
  SRD
  SEK
  CHE
  CHW
  SYP
  TWD
  TJS
  TZS
  THB
  TOP
  TTD
  TND
  TRY
  TMT
  UGX
  UAH
  AED
  USN
  UYU
  UYI
  UYW
  UZS
  VUV
  VES
  VND
  YER
  ZMW
  ZWL
  XBA
  XBB
  XBC
  XBD
  XTS
  XXX
  XAU
  XPD
  XPT
  XAG
}

fn iso_code_to_string(code: ISOCurrencyCode) -> String {
  case code {
    AFN -> "AFN"
    EUR -> "EUR"
    ALL -> "ALL"
    DZD -> "DZD"
    USD -> "USD"
    AOA -> "AOA"
    XCD -> "XCD"
    ARS -> "ARS"
    AMD -> "AMD"
    AWG -> "AWG"
    AUD -> "AUD"
    AZN -> "AZN"
    BSD -> "BSD"
    BHD -> "BHD"
    BDT -> "BDT"
    BBD -> "BBD"
    BYN -> "BYN"
    BZD -> "BZD"
    XOF -> "XOF"
    BMD -> "BMD"
    INR -> "INR"
    BTN -> "BTN"
    BOB -> "BOB"
    BOV -> "BOV"
    BAM -> "BAM"
    BWP -> "BWP"
    NOK -> "NOK"
    BRL -> "BRL"
    BND -> "BND"
    BGN -> "BGN"
    BIF -> "BIF"
    CVE -> "CVE"
    KHR -> "KHR"
    XAF -> "XAF"
    CAD -> "CAD"
    KYD -> "KYD"
    CLP -> "CLP"
    CLF -> "CLF"
    CNY -> "CNY"
    COP -> "COP"
    COU -> "COU"
    KMF -> "KMF"
    CDF -> "CDF"
    NZD -> "NZD"
    CRC -> "CRC"
    HRK -> "HRK"
    CUP -> "CUP"
    CUC -> "CUC"
    ANG -> "ANG"
    CZK -> "CZK"
    DKK -> "DKK"
    DJF -> "DJF"
    DOP -> "DOP"
    EGP -> "EGP"
    SVC -> "SVC"
    ERN -> "ERN"
    SZL -> "SZL"
    ETB -> "ETB"
    FKP -> "FKP"
    FJD -> "FJD"
    XPF -> "XPF"
    GMD -> "GMD"
    GEL -> "GEL"
    GHS -> "GHS"
    GIP -> "GIP"
    GTQ -> "GTQ"
    GBP -> "GBP"
    GNF -> "GNF"
    GYD -> "GYD"
    HTG -> "HTG"
    HNL -> "HNL"
    HKD -> "HKD"
    HUF -> "HUF"
    ISK -> "ISK"
    IDR -> "IDR"
    XDR -> "XDR"
    IRR -> "IRR"
    IQD -> "IQD"
    ILS -> "ILS"
    JMD -> "JMD"
    JPY -> "JPY"
    JOD -> "JOD"
    KZT -> "KZT"
    KES -> "KES"
    KPW -> "KPW"
    KRW -> "KRW"
    KWD -> "KWD"
    KGS -> "KGS"
    LAK -> "LAK"
    LBP -> "LBP"
    LSL -> "LSL"
    ZAR -> "ZAR"
    LRD -> "LRD"
    LYD -> "LYD"
    CHF -> "CHF"
    MOP -> "MOP"
    MKD -> "MKD"
    MGA -> "MGA"
    MWK -> "MWK"
    MYR -> "MYR"
    MVR -> "MVR"
    MRU -> "MRU"
    MUR -> "MUR"
    XUA -> "XUA"
    MXN -> "MXN"
    MXV -> "MXV"
    MDL -> "MDL"
    MNT -> "MNT"
    MAD -> "MAD"
    MZN -> "MZN"
    MMK -> "MMK"
    NAD -> "NAD"
    NPR -> "NPR"
    NIO -> "NIO"
    NGN -> "NGN"
    OMR -> "OMR"
    PKR -> "PKR"
    PAB -> "PAB"
    PGK -> "PGK"
    PYG -> "PYG"
    PEN -> "PEN"
    PHP -> "PHP"
    PLN -> "PLN"
    QAR -> "QAR"
    RON -> "RON"
    RUB -> "RUB"
    RWF -> "RWF"
    SHP -> "SHP"
    WST -> "WST"
    STN -> "STN"
    SAR -> "SAR"
    RSD -> "RSD"
    SCR -> "SCR"
    SLL -> "SLL"
    SGD -> "SGD"
    XSU -> "XSU"
    SBD -> "SBD"
    SOS -> "SOS"
    SSP -> "SSP"
    LKR -> "LKR"
    SDG -> "SDG"
    SRD -> "SRD"
    SEK -> "SEK"
    CHE -> "CHE"
    CHW -> "CHW"
    SYP -> "SYP"
    TWD -> "TWD"
    TJS -> "TJS"
    TZS -> "TZS"
    THB -> "THB"
    TOP -> "TOP"
    TTD -> "TTD"
    TND -> "TND"
    TRY -> "TRY"
    TMT -> "TMT"
    UGX -> "UGX"
    UAH -> "UAH"
    AED -> "AED"
    USN -> "USN"
    UYU -> "UYU"
    UYI -> "UYI"
    UYW -> "UYW"
    UZS -> "UZS"
    VUV -> "VUV"
    VES -> "VES"
    VND -> "VND"
    YER -> "YER"
    ZMW -> "ZMW"
    ZWL -> "ZWL"
    XBA -> "XBA"
    XBB -> "XBB"
    XBC -> "XBC"
    XBD -> "XBD"
    XTS -> "XTS"
    XXX -> "XXX"
    XAU -> "XAU"
    XPD -> "XPD"
    XPT -> "XPT"
    XAG -> "XAG"
  }
}
