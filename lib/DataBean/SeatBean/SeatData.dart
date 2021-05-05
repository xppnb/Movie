class SeatData {
  var _homeData;
  var _movieTime;
  var _movieData;

  SeatData(this._homeData, this._movieTime, this._movieData);

  get movieData => _movieData;

  set movieData(value) {
    _movieData = value;
  }

  get movieTime => _movieTime;

  set movieTime(value) {
    _movieTime = value;
  }

  get homeData => _homeData;

  set homeData(value) {
    _homeData = value;
  }
}
