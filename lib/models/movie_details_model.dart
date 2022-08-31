class MovieModel {
  MovieModel({
    required this.results,
  });
  late final Results results;

  MovieModel.fromJson(Map<String, dynamic> json) {
    results = Results.fromJson(json['results']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.toJson();
    return _data;
  }

  @override
  String toString() {
    return 'MovieModel{results: $results}';
  }
}

class Results {
  Results({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.popularity,
    required this.description,
    required this.contentRating,
    required this.movieLength,
    required this.rating,
    required this.createdAt,
    required this.trailer,
    required this.imageUrl,
    required this.release,
    required this.plot,
    required this.banner,
    required this.type,
    required this.gen,
    required this.keywords,
  });
  late final String? imdbId;
  late final String? title;
  late final int? year;
  late final int? popularity;
  late final String? description;
  late final String? contentRating;
  late final int? movieLength;
  late final double? rating;
  late final String? createdAt;
  late final String? trailer;
  late final String? imageUrl;
  late final String? release;
  late final String? plot;
  late final String? banner;
  late final String? type;
  late final List<Gen>? gen;
  late final List<Keywords>? keywords;

  Results.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    title = json['title'];
    year = json['year'];
    popularity = json['popularity'];
    description = json['description'];
    contentRating = json['content_rating'];
    movieLength = json['movie_length'];
    rating = json['rating'];
    createdAt = json['created_at'];
    trailer = json['trailer'];
    imageUrl = json['image_url'];
    release = json['release'];
    plot = json['plot'];
    banner = json['banner'];
    type = json['type'];
    gen = List.from(json['gen']).map((e) => Gen.fromJson(e)).toList();
    keywords =
        List.from(json['keywords']).map((e) => Keywords.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imdb_id'] = imdbId;
    _data['title'] = title;
    _data['year'] = year;
    _data['popularity'] = popularity;
    _data['description'] = description;
    _data['content_rating'] = contentRating;
    _data['movie_length'] = movieLength;
    _data['rating'] = rating;
    _data['created_at'] = createdAt;
    _data['trailer'] = trailer;
    _data['image_url'] = imageUrl;
    _data['release'] = release;
    _data['plot'] = plot;
    _data['banner'] = banner;
    _data['type'] = type;
    _data['gen'] = gen?.map((e) => e.toJson()).toList();
    _data['keywords'] = keywords?.map((e) => e.toJson()).toList();
    return _data;
  }

  String toStringFull() {
    return 'Results{imdbId: $imdbId, title: $title, year: $year, popularity: $popularity, description: $description, contentRating: $contentRating, movieLength: $movieLength, rating: $rating, createdAt: $createdAt, trailer: $trailer, imageUrl: $imageUrl, release: $release, plot: $plot, banner: $banner, type: $type, gen: $gen, keywords: $keywords}';
  }

  @override
  String toString() {
    return 'Results{title: $title}';
  }
}

class Gen {
  Gen({
    required this.id,
    required this.genre,
  });
  late final int id;
  late final String? genre;

  Gen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['genre'] = genre;
    return _data;
  }
}

class Keywords {
  Keywords({
    required this.id,
    required this.keyword,
  });
  late final int id;
  late final String keyword;

  Keywords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['keyword'] = keyword;
    return _data;
  }
}
