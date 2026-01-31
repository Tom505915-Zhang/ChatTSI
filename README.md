# ChatTSI

ChatTSI 是一个以“液态玻璃”视觉为核心的本地 AI 容器，目标是提供一致的跨平台体验（Windows、macOS、iOS/iPadOS）。本仓库提供 C++/Qt 6 的跨平台界面骨架与功能规划，涵盖对话、微调、训练、MCP 以及嵌入式 Python 与终端模拟的主流程。

## 设计目标

- **全平台统一界面**：基于 Qt 6 + QML，统一 Windows/macOS/iOS 的渲染与交互。
- **液态玻璃风格**：半透明、柔和渐变、微光边框与统一阴影层级。
- **本地 AI 容器**：模型运行、微调、训练、推理与工具系统在本地完成。
- **可扩展性**：支持自定义训练脚本、MCP 工具调用与多模型调度。

## 核心功能规划

### 1) 对话
- 支持对话历史与模型切换。
- 支持 MCP JSON 导入，例如:
  ```json
  {
    "tools": [
      {"name": "read_file", "args": {"path": "/user/notes/todo.md"}},
      {"name": "run_python", "args": {"code": "print('hello')"}}
    ]
  }
  ```
- 支持全局提示词，并可为单个模型排除或覆盖。

### 2) 微调
- 支持输入/输出 JSON 格式的数据微调。
- 支持引用文件路径：
  - 例如 `{"input":"/user/xxx/123.in","output":"/user/xxx/123.out"}`
  - 文件扩展名不做强制要求。

### 3) 训练
- 支持用户选择训练方向（领域、能力、任务类型等）。
- 提供常见模型类型预设（Llama、Qwen、Mistral、Phi 等）。
- 支持用户编写 Python 训练脚本（默认内置 `transformers`、`pytorch` 等库）。

### 4) 嵌入式 Python + 终端模拟
- Python 解释器嵌入式运行，面向 Windows/macOS/iPadOS。
- 终端模拟覆盖常用命令（如 `ls`、`cat`、`python` 等）。
- MCP 内置系统操作工具：读写文件、运行 Python、批处理任务等。

## 目录结构

```
.
├── CMakeLists.txt
├── README.md
├── shaders/
│   └── glass.frag
├── qml/
│   └── Main.qml
└── src/
    └── main.cpp
```

## 构建说明 (桌面端)

> 需要 Qt 6.5+ (Core, Gui, Qml, Quick, QuickControls2)

```bash
cmake -S . -B build
cmake --build build
```

## iOS / iPadOS 方向
- 使用 Qt for iOS 进行编译与打包。
- 嵌入式 Python 可通过专用运行时或本地桥接模块实现。

## 后续规划
- 接入本地模型运行时（如 llama.cpp、MLC/ggml、ONNX Runtime）。
- 增加训练管线管理与作业队列。
- 增加 MCP 运行时与安全沙箱。
- 增加终端模拟器与文件系统浏览器。
