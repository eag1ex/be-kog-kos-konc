# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [6.0.1](https://bitbucket.org/.../compare/v6.0.0...v6.0.1) (2024-01-17)

### Bug Fixes

- add function getExerciseNameAlready ([61bdaa1](https://bitbucket.org/.../commit/61bdaa12f23ff017bd0852a87d2f33ea642927e4))
- condition incorrect for booking rules ([71701d9](https://bitbucket.org/.../commit/71701d9120b59f14c3d4a82cb4e4b7adaec6cf9f))
- data is not updated ([8d8b09d](https://bitbucket.org/.../commit/8d8b09dbb12bd2546470113eae15ff701d0714d8))
- set timezone when booking from mobile ([7218153](https://bitbucket.org/.../commit/72181531e76ca8abc845049a0a6486d0019c0fb1))
- updated ([c323b32](https://bitbucket.org/.../commit/c323b32e853455e34095255f37668eced74fc750))
- updated ([cab6190](https://bitbucket.org/.../commit/cab619085f72f8632a414f1e01ad374dced969cb))
- user can update duplicate exercise name [kog-kos-konc-1991] ([43b404d](https://bitbucket.org/.../commit/43b404d957458387d9a5e7bd59cf0032c822c88a))

## [6.0.0](https://bitbucket.org/.../compare/v5.0.0...v6.0.0) (2024-01-10)

### Bug Fixes

- add condition check data ([8722b1e](https://bitbucket.org/.../commit/8722b1e0e8a2f772ea904299c6a7c4bb7081d187))
- add route getMemberPhoneNumberAlready ([dd07ce7](https://bitbucket.org/.../commit/dd07ce718d13e249f08a34a10c20eb138cfd67f3))
- adjust eslit validation ([ecd3405](https://bitbucket.org/.../commit/ecd3405f97cf3d77e0689d71705e2ee191c0a682))
- clear cache ([9b2e3d4](https://bitbucket.org/.../commit/9b2e3d4caac7dc7fdfd5fc7a634c034ab61c8243))
- eslint await-thenable, and resulting errors ([2ad487b](https://bitbucket.org/.../commit/2ad487be195b85fc3b7ef0359d1dd00d0a04c5fd))
- eslint no-duplicate-imports ([cb41695](https://bitbucket.org/.../commit/cb41695f0e3deb5d725abe26a8ce149c398cde49))
- eslint no-misused-promises ([33e7a0f](https://bitbucket.org/.../commit/33e7a0f1fd04e5872786c25ee156301db73ecf18))
- eslint no-redundant-type-constituents ([57e765f](https://bitbucket.org/.../commit/57e765f02e6a060a1fb98c23adebb7e8a632e24e))
- eslint no-unused-vars ([eee294d](https://bitbucket.org/.../commit/eee294d8cc797f79b257086926ae674493ddaae1))
- eslint restrict-plus-operands ([b0b7f1f](https://bitbucket.org/.../commit/b0b7f1f025b4b9b2baf6432dda53c1b52bf5ec85))
- eslint/prefer-const correction, and fix side-effect issues ([2826694](https://bitbucket.org/.../commit/28266945bdc7e32612b5631e5f59e1fb692fb7df))
- typo ([a001723](https://bitbucket.org/.../commit/a0017236b4e4b70c03dc185f7f1b8d92bbee8d35))
- update ([8567f9f](https://bitbucket.org/.../commit/8567f9fe33ddf75faf8ccde1c27f1360b3a4e3ad))

## [5.0.0](https://bitbucket.org/.../compare/v4.0.0...v5.0.0) (2023-12-12)

### Features

- upgrade to node@18 ([67d59e9](https://bitbucket.org/.../commit/67d59e974a96057f610e4b08c6b396a86eadfaf1))

### Bug Fixes

- migrate to yarn@3.5 to satisfy FE project requirements ([a09806b](https://bitbucket.org/.../commit/a09806b700a4aa4bccaa81f4ff56c1e9ebd052ba))

## [4.0.0](https://bitbucket.org/.../compare/v3.2.0...v4.0.0) (2023-12-12)

### Features

- fcm api syntax update due to new version migration ([61abe3c](https://bitbucket.org/.../commit/61abe3c41478676d44540258868b4688a285e5a4))
- increment firebase deps ([e413088](https://bitbucket.org/.../commit/e41308852f471efcfc063ea2b86a5f390f9f0583)) ([c9f399a](https://bitbucket.org/.../commit/c9f399a1ed3229dfb3b8588761435e5a60ba24d2)) ([fcdba73](https://bitbucket.org/.../commit/fcdba73b66beea4bbdb481ccf0e0075a5621682d))
- increment firebase package dependency versions ([51c6cff](https://bitbucket.org/.../commit/51c6cff55d4a906e08db9a6c19e0c32892464749))
- migrate from tslint to eslint, fix type errors ([814e983](https://bitbucket.org/.../commit/814e9838ce7d4057e1bd3dc76a92e400eb86d9a2))
- update firebase deps ([eeb3979](https://bitbucket.org/.../commit/eeb39797562d1e76cb5062615ddbbb78c18ac458))
- upgrade firebase major dependencies and fix new related type issues ([a6c864b](https://bitbucket.org/.../commit/a6c864bbec0541229f592749677cca4b52287b56))
- upgrade firebase deps including cloud tasks to major version ([599351b](https://bitbucket.org/.../commit/599351b7d427eb01e5db0e4589f0bd5c087c1e9b))

### Bug Fixes

- eslint and firebase build path correction to work with pipeline ([9e87b91](https://bitbucket.org/.../commit/9e87b910e649096028494ee993a212ca13362f84))
- update husky path for pipeline issue ([014e389](https://bitbucket.org/.../commit/014e3894078fd679c801c3133eac841d7fea7856))
- update package.json, move not needed dependencies to to outer package kog-kos-konc-backend-linter to avoid large deployments and limit errors ([69dcd29](https://bitbucket.org/.../commit/69dcd29516d72752a40923d7db37f362e0902126))

### Miscellaneous

- update firebase deps to compatible version range ([2fcb5bf](https://bitbucket.org/.../commit/2fcb5bf7bc7f7cd101c11a6679fa8b2d3fe29ee7))
- update firebase/project package.json for deploy fix ([3b8709a](https://bitbucket.org/.../commit/3b8709a3ada49e245f36790e2b6eeb87af61fe87))

## 3.2.0 (2023-11-27)

### Features

- commit lint, config and update packages ([2a035f0](https://bitbucket.org/.../commit/2a035f0e859cde22a84f440cb0a14f486eeb47de))

### Minor

- update readme ([224e446](https://bitbucket.org/.../commit/224e4460e728786449e2ca4cc2beaf1aa8ece175))

## 3.1.0 (2023-11-27)

### Features

- adding commit lint, config and update packages
- we have added `standard-version, commitlint` to track version release, more on it here:
- https://www.conventionalcommits.org/en/v1.0.0-beta.2/
-
- ([2a035f0](https://bitbucket.org/.../commit/2a035f0e859cde22a84f440cb0a14f486eeb47de))

# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.
