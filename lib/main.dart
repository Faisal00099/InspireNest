import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(QuoteDisplayApp());
}

class QuoteDisplayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: QuoteHomePage(),
    );
  }
}

class QuoteHomePage extends StatefulWidget {
  @override
  _QuoteHomePageState createState() => _QuoteHomePageState();
}

class _QuoteHomePageState extends State<QuoteHomePage> {
  final List<Map<String, String>> _quotes = [
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
    {
      "quote":
          "Success is not final, failure is not fatal: It is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote": "Act as if what you do makes a difference. It does.",
      "author": "William James"
    },
    {
      "quote":
          "Success usually comes to those who are too busy to be looking for it.",
      "author": "Henry David Thoreau"
    },
    {
      "quote": "The best way to predict the future is to invent it.",
      "author": "Alan Kay"
    },
    {
      "quote":
          "Do not wait to strike till the iron is hot, but make it hot by striking.",
      "author": "William Butler Yeats"
    },
    {
      "quote":
          "Whether you think you can or you think you can't, you're right.",
      "author": "Henry Ford"
    },
    {
      "quote": "The harder I work, the luckier I get.",
      "author": "Samuel Goldwyn"
    },
    {
      "quote":
          "It does not matter how slowly you go as long as you do not stop.",
      "author": "Confucius"
    },
    {
      "quote":
          "The future belongs to those who believe in the beauty of their dreams.",
      "author": "Eleanor Roosevelt"
    },
    {
      "quote": "I find that the harder I work, the more luck I seem to have.",
      "author": "Thomas Jefferson"
    },
    {
      "quote":
          "Success is not how high you have climbed, but how you make a positive difference to the world.",
      "author": "Roy T. Bennett"
    },
    {
      "quote": "You miss 100% of the shots you don't take.",
      "author": "Wayne Gretzky"
    },
    {
      "quote": "It always seems impossible until it’s done.",
      "author": "Nelson Mandela"
    },
    {
      "quote":
          "The only limit to our realization of tomorrow is our doubts of today.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote": "Act as if what you do makes a difference. It does.",
      "author": "William James"
    },
    {
      "quote": "Do what you can, with what you have, where you are.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote":
          "You are never too old to set another goal or to dream a new dream.",
      "author": "C.S. Lewis"
    },
    {
      "quote": "Everything you’ve ever wanted is on the other side of fear.",
      "author": "George Addair"
    },
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
  ];

  final List<String> _backgroundImages = [
    'assets/image1.jpeg',
    'assets/image2.jpeg',
    'assets/image3.jpeg',
    'assets/image4.jpeg',
    'assets/image5.jpeg',
    'assets/image6.jpeg',
  ];

  String _currentQuote = "";
  String _currentAuthor = "";
  String _currentImage = "";
  bool _isLoading = false;
  Map<String, String>? _previousQuote;
  String? _previousImage;

  @override
  void initState() {
    super.initState();
    _generateNewQuoteAndImage();
  }

  Future<void> _generateNewQuoteAndImage() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Simulate loading time

    final random = Random();
    Map<String, String>? newQuote;
    String? newImage;

    // Ensure new quote is different from previous
    do {
      newQuote = _quotes[random.nextInt(_quotes.length)];
    } while (newQuote == _previousQuote);

    // Ensure new image is different from previous
    do {
      newImage = _backgroundImages[random.nextInt(_backgroundImages.length)];
    } while (newImage == _previousImage);

    setState(() {
      _currentQuote = newQuote!["quote"] ?? "No quote available";
      _currentAuthor = newQuote["author"] ?? "Unknown";
      _currentImage = newImage!;
      _previousQuote = newQuote;
      _previousImage = newImage;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspirational Quotes'),
        centerTitle: true,
        // backgroundColor: Colors.orangeAccent[100],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                _currentImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback image or placeholder on error
                  return Image.asset(
                    'assets/placeholder.jpeg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.02),
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        key: ValueKey<String>(_currentQuote),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _currentQuote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.06,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '- $_currentAuthor',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.04,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _generateNewQuoteAndImage,
                              child: Text('Generate New Quote'),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
