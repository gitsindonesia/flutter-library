# Gits Cached Network Image

A flutter library to show images from the internet and keep them in the cache directory.

## How to use

The GitsCachedNetworkImage can be used directly or through the ImageProvider.

With a loading:

```dart
GitsCachedNetworkImage(
  imageUrl: 'https://picsum.photos/id/2/200',
  loadingBuilder: (context) => const CircularProgressIndicator(),
  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
);
```

```dart
Image(image: GitsCachedNetworkImageProvider(url))
```

When you want to set as background you can do with container:

```dart
Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: GitsCachedNetworkImageProvider(
            'https://picsum.photos/id/2/200',
            ),
        ),
    ),
),
```
