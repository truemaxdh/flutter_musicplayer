part of 'main.dart';

Drawer getDrawerMenu(context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        
        const SizedBox(
          height: 80.0,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Edit Song List'),
          ),
        ),
        ListTile(
          title: const Text('Add new Song'),
          onTap: () {
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditSonginfoWidget()),
            );
          },
        ),
        ListTile(
          title: const Text('Edit list'),
          onTap: () {
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditSongListWidget()),
            );
          },
        ),
      ],
    ),
  );
}
