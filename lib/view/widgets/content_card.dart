part of 'widgets.dart';

class ContentCard extends StatefulWidget {
  final Content content;
  const ContentCard(this.content);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    Content content = widget.content;

    return Card(
      color: AppColors.textColor_0,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                content.contentThumbnail!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  content.contentTitle!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content.contentDescription!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.textColor_2,
                    fontSize: 12,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.textColor_1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${content.contentDuration!.toString()} min",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
