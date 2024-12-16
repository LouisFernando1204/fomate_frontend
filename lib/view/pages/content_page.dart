part of 'pages.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text("Content", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore Insights",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // Preview Kartu
                CustomCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRU_XT_6fSIzb7tSfe1PazMka6T58PTvyH3A&s',
                  title: "How to Reduce Gadget Addiction (Dopamine Detox)",
                  description:
                      "Learn how dopamine detox helps you reset your brain, reduce gadget dependence, and regain focus.",
                  duration: "6 min",
                ),
                CustomCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRU_XT_6fSIzb7tSfe1PazMka6T58PTvyH3A&s',
                  title: "How to Reduce Gadget Addiction (Dopamine Detox)",
                  description:
                      "Learn how dopamine detox helps you reset your brain, reduce gadget dependence, and regain focus.",
                  duration: "6 min",
                ),
                CustomCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRU_XT_6fSIzb7tSfe1PazMka6T58PTvyH3A&s',
                  title: "How to Reduce Gadget Addiction (Dopamine Detox)",
                  description:
                      "Learn how dopamine detox helps you reset your brain, reduce gadget dependence, and regain focus.",
                  duration: "6 min",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomCard({
    required String imageUrl,
    required String title,
    required String description,
    required String duration,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(
                      color: Color(0xFF48CAE4),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
