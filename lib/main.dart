import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ChatTSIApp());
}

class ChatTSIApp extends StatelessWidget {
  const ChatTSIApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      title: 'ChatTSI',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
        scaffoldBackgroundColor: const Color(0xFF0B0C13),
      ),
      home: const ChatTSIHome(),
    );
  }
}

class ChatTSIHome extends StatefulWidget {
  const ChatTSIHome({super.key});

  @override
  State<ChatTSIHome> createState() => _ChatTSIHomeState();
}

class _ChatTSIHomeState extends State<ChatTSIHome> {
  String activeTab = 'chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.4,
            colors: [
              Color(0xFF2A335C),
              Color(0xFF141625),
              Color(0xFF0B0C13),
            ],
            stops: [0, 0.55, 1],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 900;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const _TopBar(),
                    const SizedBox(height: 24),
                    isCompact
                        ? Column(
                            children: [
                              _SidePanel(
                                activeTab: activeTab,
                                onTabSelected: (tab) =>
                                    setState(() => activeTab = tab),
                              ),
                              const SizedBox(height: 24),
                              _ContentArea(activeTab: activeTab),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _SidePanel(
                                  activeTab: activeTab,
                                  onTabSelected: (tab) =>
                                      setState(() => activeTab = tab),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                flex: 3,
                                child: _ContentArea(activeTab: activeTab),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '本地 AI 容器',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'ChatTSI',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: const [
              _Pill(label: 'Windows / macOS / iOS'),
              _Pill(label: '统一液态玻璃界面'),
              _Pill(label: '离线优先'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({
    required this.activeTab,
    required this.onTabSelected,
  });

  final String activeTab;
  final ValueChanged<String> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('工作区', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          Column(
            children: tabs
                .map(
                  (tab) => _TabButton(
                    label: tab.label,
                    isActive: tab.id == activeTab,
                    onPressed: () => onTabSelected(tab.id),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
          const Text('模型仓库', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          ...modelCatalog
              .map(
                (model) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.desc,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _ContentArea extends StatelessWidget {
  const _ContentArea({required this.activeTab});

  final String activeTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tabs.firstWhere((tab) => tab.id == activeTab).label,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const _StatusBadge(label: '运行中 · 容器级沙箱'),
                ],
              ),
              const SizedBox(height: 16),
              _TabBody(tab: activeTab),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('统一平台能力', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _PlatformCard(
                    title: 'Windows / macOS',
                    detail: '桌面容器保留原生文件系统访问、GPU 调度、终端模拟。',
                  ),
                  _PlatformCard(
                    title: 'iOS / iPadOS',
                    detail: '内置 Python 解释器与模型执行引擎，保证与桌面一致体验。',
                  ),
                  _PlatformCard(
                    title: '安全策略',
                    detail: '可配置离线模式、模型签名校验、权限白名单。',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody({required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case 'finetune':
        return _SplitPane(
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('输入 / 输出微调', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text(
                '支持直接上传 JSON、从应用内编辑，或引用本地文件路径（扩展名不强制）。',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              _CodeBlock(
                code: '[\n'
                    '  {\n'
                    '    "input": "用户想要的行为描述",\n'
                    '    "output": "模型期望输出"\n'
                    '  },\n'
                    '  {\n'
                    '    "input": "/user/xxx/123.in",\n'
                    '    "output": "/user/xxx/123.out"\n'
                    '  }\n'
                    ']'
                ,
              ),
            ],
          ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('微调工作流', style: TextStyle(fontSize: 18)),
              SizedBox(height: 12),
              _Timeline(items: [
                '选择基础模型与目标设备。',
                '自动校验 JSON 与文件引用。',
                '一键启动 LoRA / QLoRA / 全参数方案。',
                '生成评估报告与回滚快照。',
              ]),
            ],
          ),
        );
      case 'train':
        return _SplitPane(
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('训练模式', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Wrap(
                runSpacing: 12,
                spacing: 12,
                children: trainingModes
                    .map(
                      (mode) => _MiniCard(
                        title: mode.title,
                        detail: mode.detail,
                        tag: mode.type,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('自定义 Python 训练', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text(
                '内置 Python 运行时，预装 transformers、PyTorch 等库；iPad 端同样可用。',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              _CodeBlock(
                code: 'from transformers import AutoModelForCausalLM\n'
                    'from torch import optim\n\n'
                    'model = AutoModelForCausalLM.from_pretrained("model-id")\n'
                    'optimizer = optim.AdamW(model.parameters(), lr=3e-5)\n'
                    '# ...自定义训练循环...'
                ,
              ),
            ],
          ),
        );
      case 'terminal':
        return const _TerminalCard();
      case 'mcp':
        return _SplitPane(
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('MCP 管理', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text(
                '通过 JSON 导入 MCP 集合，配置系统操作、文件读写与 Python 运行。',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 16),
              _CodeBlock(
                code: '{\n'
                    '  "tools": [\n'
                    '    { "name": "file.read", "scope": "system" },\n'
                    '    { "name": "python.exec", "scope": "system" }\n'
                    '  ]\n'
                    '}',
              ),
            ],
          ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('函数式动作', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text(
                '模型可声明函数签名与参数，容器将按顺序执行并回填结果。',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 12),
              _Checklist(items: [
                '支持多步骤串联与回滚。',
                '可选执行策略：安全 / 自由 / 审批。',
                '与对话上下文同步。',
              ]),
            ],
          ),
        );
      case 'chat':
      default:
        return _SplitPane(
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('统一提示词', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              const Text(
                '可为所有会话定义全局提示词，也可选择某类模型或单个模型不适用。',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Wrap(
                runSpacing: 12,
                spacing: 12,
                children: promptPresets
                    .map(
                      (preset) => _MiniCard(
                        title: preset.title,
                        detail: preset.detail,
                        tag: preset.scope,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('对话引擎', style: TextStyle(fontSize: 18)),
              SizedBox(height: 12),
              _Checklist(items: [
                '支持 MCP JSON 形式导入对话能力。',
                '模型可暴露“函数”，由容器执行连贯操作。',
                '内置系统 MCP：读写文件、Python 运行、终端调用。',
              ]),
              SizedBox(height: 12),
              _ChatPreview(),
            ],
          ),
        );
    }
  }
}

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.16)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.16),
                Colors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0A1028).withOpacity(0.35),
                blurRadius: 80,
                offset: const Offset(0, 30),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive
        ? const Color(0xFF70A7FF).withOpacity(0.6)
        : Colors.transparent;
    final background = isActive
        ? const Color(0xFF70A7FF).withOpacity(0.18)
        : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
            color: background,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFF57FFA5).withOpacity(0.14),
        border: Border.all(color: const Color(0xFF57FFA5).withOpacity(0.3)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _SplitPane extends StatelessWidget {
  const _SplitPane({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isStacked = constraints.maxWidth < 720;
        return isStacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  left,
                  const SizedBox(height: 24),
                  right,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: left),
                  const SizedBox(width: 24),
                  Expanded(child: right),
                ],
              );
      },
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.title,
    required this.detail,
    required this.tag,
  });

  final String title;
  final String detail;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 220),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(detail, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: Colors.white.withOpacity(0.15),
            ),
            child: Text(tag, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _Checklist extends StatelessWidget {
  const _Checklist({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✦ ', style: TextStyle(color: Color(0xFF7FD3FF))),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ChatPreview extends StatelessWidget {
  const _ChatPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.18),
          ),
          child: const Text('用 MCP 加载新的知识库。'),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF57FFA5).withOpacity(0.15),
          ),
          child: const Text('已解析 12 个 MCP 条目，准备生成函数调用。需要执行吗？'),
        ),
      ],
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF0A0E1E).withOpacity(0.75),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Text(
        code,
        style: const TextStyle(fontFamily: 'SF Mono', fontSize: 13),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: Colors.white70)),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TerminalCard extends StatelessWidget {
  const _TerminalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
        color: const Color(0xFF0A0E1E).withOpacity(0.85),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white.withOpacity(0.08),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('ChatTSI Terminal', style: TextStyle(fontSize: 12)),
                _Pill(label: '模拟常见命令'),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r'$ ls /models'),
                Text('llama-3.q4.gguf  mistral-7b  qwen2.5'),
                SizedBox(height: 8),
                Text(r'$ python train.py --preset quick'),
                Text('[ok] 已挂载本地 GPU · 显存 24GB'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  const _PlatformCard({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.16)),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(detail, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _Tab {
  const _Tab({required this.id, required this.label});

  final String id;
  final String label;
}

class _ModelInfo {
  const _ModelInfo({required this.name, required this.desc});

  final String name;
  final String desc;
}

class _PromptPreset {
  const _PromptPreset({required this.title, required this.detail, required this.scope});

  final String title;
  final String detail;
  final String scope;
}

class _TrainingMode {
  const _TrainingMode({required this.title, required this.detail, required this.type});

  final String title;
  final String detail;
  final String type;
}

const tabs = [
  _Tab(id: 'chat', label: '对话'),
  _Tab(id: 'finetune', label: '微调'),
  _Tab(id: 'train', label: '训练'),
  _Tab(id: 'terminal', label: '终端'),
  _Tab(id: 'mcp', label: 'MCP'),
];

const modelCatalog = [
  _ModelInfo(name: 'Llama 3.x', desc: '通用对话与工具调用，适配桌面与移动端。'),
  _ModelInfo(name: 'Qwen 2.5', desc: '多语言能力与长文本理解。'),
  _ModelInfo(name: 'Mistral 7B', desc: '高效轻量，适合本地端侧推理。'),
  _ModelInfo(name: 'Custom GGUF', desc: '支持自带权重或量化格式。'),
];

const promptPresets = [
  _PromptPreset(
    title: '全局系统提示词',
    detail: '对全部对话生效，约束语气与输出格式。',
    scope: '所有模型',
  ),
  _PromptPreset(
    title: '模型排除规则',
    detail: '为指定模型禁用某些提示词或安全策略。',
    scope: '单模型',
  ),
  _PromptPreset(
    title: '任务提示模板',
    detail: '快速为某类任务加载结构化提示词。',
    scope: '模型组',
  ),
];

const trainingModes = [
  _TrainingMode(
    title: '指令微调',
    detail: '面向对话任务的监督式训练与自动评估。',
    type: 'SFT',
  ),
  _TrainingMode(
    title: '偏好优化',
    detail: '支持 DPO、ORPO 等偏好对齐方案。',
    type: 'Preference',
  ),
  _TrainingMode(
    title: '检索增强',
    detail: '接入自定义知识库与检索器进行联合训练。',
    type: 'RAG',
  ),
  _TrainingMode(
    title: '多模态扩展',
    detail: '文字 + 视觉输入的联合训练管线。',
    type: 'Multimodal',
  ),
];
