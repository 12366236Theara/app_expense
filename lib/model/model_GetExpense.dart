class ModelGetExpense {
  int? iD;
  int? uSERID;
  int? aMOUNT;
  String? cATEGORY;
  String? dATE;
  String? nOTES;

  ModelGetExpense(
      {this.iD,
      this.uSERID,
      this.aMOUNT,
      this.cATEGORY,
      this.dATE,
      this.nOTES});

  ModelGetExpense.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uSERID = json['USER_ID'];
    aMOUNT = json['AMOUNT'];
    cATEGORY = json['CATEGORY'];
    dATE = json['DATE'];
    nOTES = json['NOTES'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['USER_ID'] = this.uSERID;
    data['AMOUNT'] = this.aMOUNT;
    data['CATEGORY'] = this.cATEGORY;
    data['DATE'] = this.dATE;
    data['NOTES'] = this.nOTES;
    return data;
  }
}
