import 'package:care_me/Service/UserService.dart';
import 'package:flutter/material.dart';

import '../Service/User.dart';

class HealerView extends StatelessWidget {
  const HealerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: HealerPane(),
    );
  }
}

class HealerPane extends StatefulWidget {
  const HealerPane({Key? key}) : super(key: key);

  @override
  createState() => _HealerPane();
}

class _HealerPane extends State<HealerPane> {
  late List<User> listOfUsers;

  @override
  void initState() {
    super.initState();
    listOfUsers = UserService().getUsers() as List<User>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listOfUsers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final user = listOfUsers[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserPage(user: user),
                ));
              },
              leading: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(user.image!),
              ),
              title: Text(user.username),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final User user;

  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              user.name!,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      );
}
