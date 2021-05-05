class OrderData {
  var _homeData;
  var _movieTime;
  var _movieData;
  var _seatNumber;
  double _priceNum;


  OrderData(this._homeData, this._movieTime, this._movieData, this._seatNumber,
      this._priceNum);

  get seatNumber => _seatNumber;

  set seatNumber(value) {
    _seatNumber = value;
  }

  get movieData => _movieData;

  set movieData(value) {
    _movieData = value;
  }

  get movieTime => _movieTime;

  set movieTime(value) {
    _movieTime = value;
  }

  double get priceNum => _priceNum;

  set priceNum(double value) {
    _priceNum = value;
  }

  get homeData => _homeData;

  set homeData(value) {
    _homeData = value;
  }
}
