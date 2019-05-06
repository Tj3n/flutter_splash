// {
//   "page": 1,
//   "total_results": 19772,
//   "total_pages": 989,
//   "results": [
//     {
//       "vote_count": 6503,
//       "id": 299536,
//       "video": false,
//       "vote_average": 8.3,
//       "title": "Avengers: Infinity War",
//       "popularity": 350.154,
//       "poster_path": "\/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
//       "original_language": "en",
//       "original_title": "Avengers: Infinity War",
//       "genre_ids": [
//         12,
//         878,
//         14,
//         28
//       ],
//       "backdrop_path": "\/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
//       "adult": false,
//       "overview": "As the Avengers and their allies have continued to protect the world from threats too large for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos. A despot of intergalactic infamy, his goal is to collect all six Infinity Stones, artifacts of unimaginable power, and use them to inflict his twisted will on all of reality. Everything the Avengers have fought for has led up to this moment - the fate of Earth and existence itself has never been more uncertain.",
//       "release_date": "2018-04-25"
//     }
//   ]
// }

class MovieListModel {
  int page;
  int totalMovie;
  int totalPages;
  List<Movie> movies;

  MovieListModel({this.page, this.totalMovie, this.totalPages, this.movies});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalMovie = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = new List<Movie>();
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalMovie;
    data['total_pages'] = this.totalPages;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int voteCount;
  int id;
  bool video;
  num voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie(
      {this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}