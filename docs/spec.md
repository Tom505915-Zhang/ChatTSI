# ChatTSI 需求与架构草案

## 目标
- 构建统一液态玻璃界面的本地 AI 容器，跨 Windows、macOS、iOS（含 iPad）。
- 核心能力：对话、微调、训练、可编程扩展、系统 MCP。

## 容器能力摘要
- **模型管理**：内置常见模型目录，支持加载本地权重（GGUF、Safetensors 等）。
- **微调**：输入/输出 JSON 支持文件引用，示例：`/user/xxx/123.in` 与 `/user/xxx/123.out`。
- **训练**：支持 SFT / Preference / RAG / 多模态训练；支持用户自定义 Python 训练脚本。
- **对话**：MCP JSON 导入工具集；模型可声明函数签名，容器按步骤执行并回填结果。
- **终端**：内置模拟终端，覆盖常见命令，提供环境信息反馈。

## 跨平台一致性策略
- **App UI 层**：Flutter 提供统一组件、玻璃质感主题与动画，保持桌面和移动端一致体验。
- **运行层**：桌面采用本地 GPU 计算，移动端采用优化推理引擎并保持一致接口。
- **嵌入式 Python**：桌面与 iPad 均嵌入解释器，预装 transformers、PyTorch 等库。
- **可执行产物**：统一通过 Flutter 构建流程输出 Windows、macOS、iOS 可执行包。

## MCP 内置清单建议
- 文件操作：`file.read`, `file.write`, `file.list`
- Python 执行：`python.exec`, `python.env`
- 终端调用：`terminal.run`, `terminal.session`
- 模型动作：`model.invoke`, `model.train`, `model.finetune`

## 安全策略
- 权限白名单与审计日志。
- 模型签名校验与可选离线模式。
- MCP 访问范围限制。
