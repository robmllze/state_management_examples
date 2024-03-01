import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Application state
class AppState {
  final int counter;

  AppState({this.counter = 0});
}

// Actions
class IncrementAction {}

class DecrementAction {}

// Reducer
AppState counterReducer(AppState state, dynamic action) {
  if (action is IncrementAction) {
    return AppState(counter: state.counter + 1);
  } else if (action is DecrementAction) {
    return AppState(counter: state.counter - 1);
  }

  return state;
}

void main() {
  final store = Store<AppState>(counterReducer, initialState: AppState());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Redux Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StoreConnector<AppState, String>(
              converter: (store) => store.state.counter.toString(),
              builder: (context, counter) => Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(IncrementAction());
        },
        builder: (context, callback) => FloatingActionButton(
          onPressed: callback,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(DecrementAction()),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => StoreProvider.of<AppState>(context).dispatch(IncrementAction()),
            ),
          ],
        ),
      ),
    );
  }
}
