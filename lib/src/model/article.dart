
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Equatable{

  late final String title;
  late final String? author;
  late final String? description;
  late final String? urlToImage;
  late final String? content;
  late final String? url;
  
  Article({
    required this.title,
    this.author,
    this.description,
    this.urlToImage,
    this.content,
    this.url
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArticleToJson(this);

    @override
  // TODO: implement props
  List<Object?> get props => [title];

}
