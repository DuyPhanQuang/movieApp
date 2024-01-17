## Getting Started
This project is a coding test mobile app for apply MetaCrew

## Flutter version
- Flutter 3.16.7 • channel stable
- Dart 3.2.4 • DevTools 2.28.5

## How to run app
Because I used window-PC to develop so please test on `ANDROID DEVICE` first.

## Pull refresh and Load more solution
There are many approach implement load more feature. 
- Use pull_to_refresh packages (https://pub.dev/packages/pull_to_refresh) will help us save a lot time to build UI/animation for pull to refresh and load more behavior.
- Use RefreshIndicator(https://api.flutter.dev/flutter/material/RefreshIndicator-class.html) perform user pull to refresh data. Also, use visibility_detector(https://pub.dev/packages/visibility_detector) for preload data when user scroll up vertical/horizontal list view.
In this resource, i applied 2nd solution

## Responsive layout
- Will apply responsive_framework packages to resize and scale UI for application(web/app)

## Architecture

Apply Clean Architecture(Custom) + BloC pattern

```
|---------------  Layers  --------------|  
| Presentations | Business Logic | Data |  
|:-------------------------------------:|  
  
|-------------------------------------------------------------------  Actual  --------------------------------------------------------------------|
|     Presentations      |                                 Business Logic                                |                  Data                  |  
|:-----------------------------------------------------------------------------------------------------------------------------------------------:|  
| View <--> Common/Module Bloc <--> Common/Module Interactor <--> Repository <--> Remote DataSource / Local DataSource --------------------------:|  
|:-----------------------------------------------------------------------------------------------------------------------------------------------:|  
|:----                   Extension Entity                  ----|----                                Basic Entity                             ----:|  
|:-----------------------------------------------------------------------------------------------------------------------------------------------:|  
```

### View
- This is the major view layer of mobile app and is categorized by module (feature or epic).
- View (widget) is rendered based on the bloc state if needed.
- Widgets that are used across module will be placed in *widgets folder* and **MUST NOT** build based on bloc state.
- A widget or screen can have multiple blocs to control UI's state or no blocs at all.

Examples of a standard widget that build based on bloc states:
```dart
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderBloc, LoaderState>(
      builder: (context, state) {
        return Visibility(
            visible: state is LoaderRunSuccess,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
```

### Common/Module Bloc
- It's the main stateful layer that keep all app's state and data.
- Data must keep in State class, not in bloc itself
- Bloc can handle all UI's business, such as proceed an user's action, control loading flow, change theme or update new language,
  ... All UIs that need update by state, it's responsible of Bloc
- Bloc is managed through by BlocManager, control constructor and dispose, communicate between blocs by add event or listen state changes,
  and even for broadcast on global channel
- The naming convention to define Event and State class can reference [here](https://bloclibrary.dev/#/blocnamingconventions)
- State class **MUST** be extended by Equatable, but Event class.
- BaseBloc is advanced class of Bloc to handle some generic business such as show/hide app loading (locked loading)
  , handle callApi with common error handling.
- Bloc key is required for all blocs, use Constants to define key.
- Bloc can reference to multiple module interactor, common interactor to handle business, but less is better.

Example of Bloc new instance:
```dart
  BlocProvider<DashboardBloc>(create: (_) => DashboardBloc.instance())
```

Static method for bloc constructor:
```dart
  static DashboardBloc instance() {
    return BlocManager().newBloc<DashboardBloc>(BlocConstants.dashboard);
  }
```

and the constructor in DI class:
```dart
  DashboardBloc: (Key key) => DashboardBloc(key, dashboardInteractor: getIt<DashboardInteractor>());
```

### Common/Module Interactor
- It's the main layer to handle corresponding data business of module.
- It's a stateless layer, so it will be constructed on demand
- A common/module interactor may contain many usecases that belong to a same module or epic
- A common/module interactor can communicate with other common/module interactor
- All common/module interactors **MUST** be defined with an interface (abstract class), bloc communicate with common/module interactor through by the interface

### Repository
- The main data source of app that is used by common/module interactor layer
- It's a stateless layer, so it will be constructed on demand
- It contains a little bit business rules to branch data source that should be used, from remote datasource or local datasource
- It also handle the caching logic rules, from memory or local storage
- All repositories **MUST** be defined with an interface (abstract class), common/module interactor communicate with repository through by the interface

### Remote datasource/Local datasource
- It's data source layer, Remote datasource means data is from RestFul API, GraphQL and Local datasource means data is from local storage
- Base Remote datasource is advanced class to handle all generic calling API, retry when access token is expired
  and need to refresh, also for general API error handling
- Base Local datasource is advanced class to handle the generic storage, save/get list or item, or even for a string or an integer or a boolean.
- All Remote datasource & Local datasource **MUST** be defined with an interface (abstract class), api repository communicate with remote datasource/local datasource through by the interface

### Model
- It covers all entities in app
- Have 2 kind of models, basic entity and extension entity.
- Basic entity is belong to repository, it defines all entity's properties and support basic parsing with JSON
- Extension entity is belong to UI layer, it defines all utility methods of an entity and the suffix name should include character such as `series` or `spec`
- All entity **MUST** extended by Equatable that useful in smart comparison

## Dependencies Injection
- GetIt will cover all layers in app that provide instance of interactor, module/common repository, remote & local datasource.
- BlocManager is a singleton class that not only work as a bloc manager but also support to provider bloc instance. All constructor of bloc should be a static function inside Bloc class for easy to maintain.
- Common/Module interactor is a factory class.
- Common repository is a factory class.
- Remote datasource is a singleton class
- Local datasource is a factory class

Example of GetIt register layer:
```dart
      getIt.registerFactory<MovieRepository>(
          () => MovieRepositoryImpl(
          tvRepository: getIt<TVRepository>(),
          ),
      );
```

and get instance of layer:
```dart
  getIt<MovieRepository>();
```

## Code Structure
Here is list all of key folders or files in code structure:
