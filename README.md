# Crisper

This is a simple and easy-to-use dependency injection container.
It makes easy to implement a dependency injection pattern with
loosely coupled components. It does not replace a complex dependency
injection framework like Dagger, but it provides the basics that most
apps need.

## Feature
* Register dependencies using Module
* Support of multiple modules with scopes
* Create factory instances
* Create lazily-computed instance
* Support tagged types
* Detect circular dependencies
* Getting instances from anywhere, including Module

## Usage

### Define module:

```
class SomeModule implements Module {
  @override
  void setup(Binder binder) {
    binder.bindsLazyInstance(() => "123");
    binder.bindsLazyInstance(() => "123", tag: "second");
    binder.bindsFactory(() => ValueNotifier<int>(0));
  }
}
```

### Register module:

add Module to global scope

```
  IoContainer.take().add(SomeModule());
```

or add Module to own scope

```
  IoContainer.take().add(SomeModule(), scope: ScopeType);
```

when the scope is closed, you can remove scoped dependencies

```
  IoContainer.take().removeScope(ScopeType);
```

### Get instances:

```
  // default
  final first = get<String>();
  // tagged
  final second = get<String>(tag: "second");
  // scoped
  final third = get<String>(scope: ScopeType);
```