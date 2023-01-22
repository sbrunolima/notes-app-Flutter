import 'package:flutter/material.dart';

class AboutAuthor extends StatelessWidget {
  final List<String> _personalData = [
    "sbrunolima",
    "Flutter Engineer",
    "Bruno L. Santos",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              Card(
                color: Colors.white,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profile('Name:', _personalData[2], context),
                  const SizedBox(height: 10),
                  profile('Role:', _personalData[1], context),
                  const SizedBox(height: 10),
                  profile('GitHub:', _personalData[0], context),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          titles('SKILLS:', context),
          skills('Programming:', 'Dart, C#, SQL, Java', context),
          skills('Frameworks:', 'Flutter, Unity', context),
          skills('Tools:', 'Git, GitHub, Firebase, Google Play', context),
          skills('Spoken Languages:', 'Portuguese, English', context),
        ],
      ),
    );
  }

  Widget profile(String title, String name, BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.blue,
              ),
        ),
        const SizedBox(width: 5),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget bodyContent(String content, BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
    );
  }

  Widget skills(String title, String name, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.blue,
                ),
          ),
          const SizedBox(width: 5),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget titles(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
