# ChatTSI

ChatTSI 是一个面向 Windows、macOS 与 iOS 的本地 AI 容器概念设计与跨端 App 原型。它采用统一的液态玻璃 UI 语言，覆盖对话、微调、训练、终端与 MCP 管理等核心场景。

## 功能概览
- **对话**：MCP JSON 导入、系统工具、函数式动作。
- **微调**：输入/输出 JSON 支持文件引用与应用内编辑。
- **训练**：支持 SFT / Preference / RAG / 多模态训练，以及自定义 Python 训练。
- **终端**：模拟常见命令，展示运行状态。

## 本地运行（Flutter 原型）
```bash
flutter pub get
flutter run -d macos
```

## 可执行文件构建
```bash
./scripts/build_app.sh macos
./scripts/build_app.sh windows
./scripts/build_app.sh ios
```

> 仅包含 App UI 原型与架构说明，后续可接入真实的模型容器与系统 MCP。
