class HelperModel {
  final String name;
  final double rating;
  final String jobs;
  final double distance;

  const HelperModel({
    required this.name,
    required this.rating,
    required this.jobs,
    required this.distance,
  });
}

const helper = HelperModel(
  name: "Akash Kumar",
  rating: 4.8,
  jobs: "50+",
  distance: 1.2,
);
