import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 800
    title: "ChatTSI"
    color: "#0b0f19"

    Rectangle {
        id: glassPanel
        anchors.centerIn: parent
        width: parent.width * 0.88
        height: parent.height * 0.86
        radius: 28
        color: "#1a2235"
        border.color: "#7aa2f7"
        border.width: 1
        opacity: 0.86

        layer.enabled: true
        layer.effect: ShaderEffect {
            property color tint: "#6ee7ff"
            fragmentShader: "qrc:/ChatTSI/shaders/glass.frag"
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 32
            spacing: 20

            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Label {
                    text: "ChatTSI"
                    font.pixelSize: 32
                    color: "#f8fafc"
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#35415f"
                }

                Button {
                    text: "连接 MCP"
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 24

                ColumnLayout {
                    Layout.preferredWidth: 280
                    spacing: 16

                    GroupBox {
                        title: "模型管理"
                        Layout.fillWidth: true
                        ColumnLayout {
                            spacing: 12
                            Label { text: "模型类型"; color: "#cbd5f5" }
                            ComboBox {
                                model: ["Llama", "Qwen", "Mistral", "Phi", "Custom"]
                                Layout.fillWidth: true
                            }
                            Label { text: "全局提示词"; color: "#cbd5f5" }
                            TextArea {
                                placeholderText: "为所有对话设置系统提示词（可按模型指定）"
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                            }
                        }
                    }

                    GroupBox {
                        title: "终端 / Python"
                        Layout.fillWidth: true
                        ColumnLayout {
                            spacing: 12
                            Label { text: "嵌入式 Python (transformers, pytorch)"; color: "#cbd5f5" }
                            Button { text: "打开交互式终端" }
                            Button { text: "运行 Python 脚本" }
                        }
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    GroupBox {
                        title: "对话区"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        ColumnLayout {
                            spacing: 12
                            TextArea {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                placeholderText: "对话输出 / MCP 消息 (JSON)"
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                TextField {
                                    Layout.fillWidth: true
                                    placeholderText: "输入消息"
                                }
                                Button { text: "发送" }
                            }
                        }
                    }

                    GroupBox {
                        title: "训练与微调"
                        Layout.fillWidth: true
                        ColumnLayout {
                            spacing: 12
                            RowLayout {
                                Layout.fillWidth: true
                                Button { text: "加载训练数据" }
                                Button { text: "自定义训练脚本" }
                                Button { text: "开始训练" }
                            }
                            TextArea {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 120
                                placeholderText: "支持输入/输出 JSON 或引用文件路径，如 /user/xxx/123.in -> /user/xxx/123.out"
                            }
                        }
                    }
                }
            }
        }
    }
}
