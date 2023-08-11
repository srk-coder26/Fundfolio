class GetFundModel {
  String? fundName, //
      fundType, //
      fundCurrentPrice, //
      fundCurrentChange, //
      fundChangePercent,
      fundPercent,
      fundInvestment, //
      fundCurrentValue,
      fundReturns,
      gainerFunds,
      loserFunds,
      fundUnits; //

  GetFundModel({
    this.fundName,
    this.fundType,
    this.fundCurrentPrice,
    this.fundCurrentChange,
    this.fundChangePercent,
    this.fundReturns,
    this.fundPercent,
    this.gainerFunds,
    this.loserFunds,
    this.fundCurrentValue,
    this.fundInvestment,
    this.fundUnits,
  });

  factory GetFundModel.fromJson(Map<String, dynamic> json) {
    return GetFundModel(
      fundName: "${json['Fund Names']}",
      fundType: "${json['Stock Type']}",
      fundCurrentPrice: "${json['Current NAV']}",
      fundCurrentChange: "${json['Change ₹']}",
      fundReturns: "${json['Gain ₹']}",
      fundPercent: "${json['Gain %']}",
      fundInvestment: "${json['Invested Amount']}",
      fundUnits: "${json['Units']}",
      fundCurrentValue: "${json['Current Value']}",
    );
  }

  Map toJson() => {
        "fundName": fundName,
        "fundType": fundType,
        "fundCurrentPrice": fundCurrentPrice,
        "fundCurrentChange": fundCurrentChange,
        "fundReturns": fundReturns,
        "fundPercent": fundPercent,
        "fundInvestment": fundInvestment,
        "fundUnits": fundUnits,
      };
}
