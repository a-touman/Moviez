//  represents cards
class MoviePoster {
  String _movieBanner;
  String _movieID;

  MoviePoster(this._movieBanner, this._movieID);

  String get movieID => _movieID;

  String get movieBanner => _movieBanner;

  @override
  String toString() {
    return '{_movieBanner: $_movieBanner, _movieID: $_movieID}';
  }
}
