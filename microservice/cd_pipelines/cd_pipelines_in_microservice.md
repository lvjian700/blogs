#Insight - 持续部署 Microservices 的实践和准则

当提到 microservice 的时候，我们通常会从下图开始：

为了从业务和技术方面得到更好的扩展能力，我们将单一架构的系统 ( Monolithic architecture)，拆分成若干的微服务 ( Microservice architecture )，这种拆分是架构演进的一个过程。
在整个拆分过程中，对团队的组织架构，数据的管理方式，部署监控技术方面都带来极大的挑战。

在拆分 services 之后，每个 service 都需要独立部署，我们需要为每个 service 搭建 CD pipeline。持续部署是 microservice 架构中一个必备的实践之一，本文将介绍持续部署 microserivce 的实践和准则：

实践:

* 使用 Docker 构建和发布 service
* 采用 Docker Compose 运行测试
* 使用 Docker 进行部署

准则: 

* Build pipeline as Code
* Infrastructure as Code
* 共享构建脚本


## 使用 Docker 构建和发布 service

- 使用 Docker 构建 service，service 已 docker image 的方式发布
- 将 docker 发布到 docker registry，并且进行版本化管理
- 从 docker registry 上 pull docker image 进行部署

## 使用 Docker Compose 运行测试

Docker Compose可以将多个 docker image 进行组合。有些 service 需要访问数据，我们可以通过 docker compose 将 service image 和 database image 组合在一起。组合之后，我们可以采用 docker compose 运行 Unit Test 和 Integration Test。

## Build pipeline as Code

通常我们使用 Jenkins 或者 Bamboo 来搭建 CI/CD pipeline，每次创建 pipeline 需要进行大量的手工配置，此时很难自动化 CI 服务器配置。
Build pipeline as Code，即使用代码来描述 pipeline，这样做可以带来非常好的可读性和重用性。我们可以很容易的做到 CI 服务器配置。
今年团队将所有 pipeline 从 Bamboo 迁移到了 BuildKite。在 BuildKite 上可以使用如下代码描述上图的 pipeline：

```
steps:
  -
    name: "Run my tests"
    command: "ci/bin/test"
    agents:
      queue: test

  - wait

  -
    name: "Push docker image"
    command: "ci/bin/docker-tag"
    branches: "master"
    agents:
      queue: test

  - wait

  -
    name: "Deploy To Test"
    command: "ci/bin/deploy"
    branches: "master"
    env:
      DEPLOYMENT_ENV: test
    agents:
      queue: test

  - block

  - name: "Deploy to Production"
    command: "ci/bin/deploy"
    branches: "master"
    env:
      DEPLOYMENT_ENV: prod
    agents:
      queue: production
```

## Infrastructure as Code

如果我们要发布一个基于 HTTP 协议的 REST-ful API service，我们需要 service 准备如下基础设施（Infrastructure）：

* 可部署的机器
* 机器的 IP 和网络配置
* 设备硬件监控服务（GPU，Memory 等）
* 负载均衡（Load Balancer）
* DNS
* AutoScaling （services 自动伸缩服务）
* Splunk 日志收集
* NewRelic 性能监控
* Sentry.io 和 PagerDuty 报警

这些基础设施的搭建和配置我们希望将其模板化，自动化。我们才用代码描述基础设施，DevOps 提供工具模板化基础设施的描述。

实践：

* 采用 AWS 云服务进行部署
* 采用 AWS CloudFormation 描述和创建资源
* 将对资源操作的脚本进行 source control

准则：

* 对资源的描述和操作应该在 git 中
* 在所有环境中采用相同的部署流程
* 使用 ssh 等手动操作资源的方式，只能用于测试环境或者在测试环境上做一些 debug。

## 共享构建脚本

在为多个 services 搭建 CD pipeline 之后，我们将 CD pipeline 归纳为三部：

1. 运行测试
2. 构建发布 docker image
3. 部署

分别为这三步提取出 shell scripts：

1. test.sh
2. docker-tag.sh
3. deploy <test|prod>

之后为上述脚本创建 git repository，并且将其以 git submodule 的方式引入各个 service 中。

## 让 CD pipeline 服务团队

团队职责：

* 团队主要分为 BA，Developer（简称 Dev），Tech Lead（简称TL）
* BA 负责分析业务，并在故事墙上创建 Story
* Dev 负责开发，QA，运维（跨能型团队）
* Tech Lead 负责技术

工作流程：

1. Dev 从 Backlog 中拿卡进行分析，分析完成后跟 BA，TL一起 kickoff 确定需求、技术实现。
2. kickoff 之后， Dev 在 repository 上创建 Pull Request（简称 PR） 开始工作。此时在 PR 上的每一次 git push 会触发 PR 的 pipeline，此时在 CI 机器上只会运行单元测试和集成测试。
3. Dev 开发完成后，其他 Dev 对 PR 进行 Review，Review 通过之后将 PR merge 到 master 分支，此时会 trigger master 分支上的 pipeline，将最新代码自动部署到 test 环境。
4. 部署 test 环境成功后，Dev 基于 test 环境进行 QA。
5. QA 完成后向 BA, TL 做 showcase 进行 user acceptance test。
6. 通过 user acceptance test 之后，在 BuildKite 上点击部署到 production 按钮完成发布。

按照以上流程，团队可以快速从 CI/CD pipeline 上得到反馈，高度自动化的 CD pipeline 可以让团队做到按照 Story 进行 service 发布。

## 总结

Microsservices 在业务和技术的扩展性方面带来了极大的便利，同时在组织和技术层面带来的极大的挑战。由于在架构的演进过程中，会有很多新服务产生，持续部署是技术层面的挑战之一，好的持续部署实践和准则可以让团队从基础设施抽离出来，关注与产生业务价值的功能实现。


