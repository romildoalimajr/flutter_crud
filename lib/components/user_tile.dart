import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:provider/provider.dart';

import '../provider/users.dart';
import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit), color: Colors.orange, onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
            }),
            IconButton(
                icon: Icon(Icons.delete), color: Colors.red, onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Tem certeza???'),
                      actions: <Widget>[
                        FloatingActionButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          } ,
                          child: Text('Não'),
                        ),
                        FloatingActionButton(
                          onPressed: (){
                            Provider.of<Users>(context, listen: false).remove(user);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    ),
                  );

            }),
          ],
        ),
      ),
    );
  }
}
