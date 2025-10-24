# RDN 术前快速评估与指南参考工具 V7.0 (指南精简版)
# 作者: AI (根据用户反馈修订)
# 数据来源: 中华心血管病杂志, 及各大高血压指南

# 1. 安装和加载所需的包
# install.packages(c("shiny", "shinythemes"))
library(shiny)
library(shinythemes)

# 2. 定义用户界面 (UI)
ui <- fluidPage(
  theme = shinytheme("cosmo"),
  
  titlePanel(
    div(
      style = "display: flex; align-items: center;",
      img(src = "https://raw.githubusercontent.com/rstudio/hex-stickers/main/PNG/shiny.png", height = "50px", style = "margin-right: 15px;"),
      h2("经皮去肾交感神经术 (RDN) 评估与指南参考工具", style = "margin: 0;")
    )
  ),
  
  navlistPanel(
    "功能导航",
    widths = c(3, 9),
    
    # --- 欢迎与说明 ---
    tabPanel(
      "欢迎与说明",
      icon = icon("info-circle"),
      h3("工具简介"),
      p("本工具旨在结合中国及国际权威指南，为临床医生提供一个快速、便捷的RDN术前评估与决策参考。"),
      p("请按照左侧导航栏的步骤完成评估，或直接查阅国际指南推荐。本工具的评估结果", strong("不能替代"), "最终的临床诊断和多学科团队（MDT）决策。"),
      hr(),
      h4("核心信息来源"),
      tags$div(
        style = "font-size: 14px;",
        tags$ul(
          tags$li("中华医学会心血管病学分会，中华心血管病杂志编辑委员会. 经皮去肾交感神经术治疗高血压专家建议. 中华心血管病杂志，2025，53(01):6-15. DOI:10.3760/cma.j.cn112148-20240905-00513"),
          tags$li("李月平.经皮去肾神经术治疗高血压临床路径中国专家共识（2025版）[J].中国介入心脏病学杂志,2025,v.33;No.242(09):481-490"),
          tags$li("中华医学会心血管病学分会, 海峡两岸医药卫生交流协会高血压专业委员会, 中国康复医学会心血管疾病预防与康复专业委员会. 中国高血压临床实践指南[J]. 中华心血管病杂志, 2024, 52(9): 985-1032."),
          tags$li("Jones DW, Ferdinand KC, Taler SJ, et al. 2025 AHA/ACC/AANP/AAPA/ABC/ACCP/ACPM/AGS/AMA/ASPC/NMA/PCNA/SGIM Guideline for the Prevention, Detection, Evaluation, and Management of High Blood Pressure in Adults: A Report of the American College of Cardiology/American Heart Association Joint Committee on Clinical Practice Guidelines. J Am Coll Cardiol. Published online May 7, 2025. https://doi.org/10.1016/j.jacc.2025.05.007."),
          tags$li("McEvoy JW, McCarthy CP, Bruno RM, et al. 2024 ESC Guidelines for the management of elevated blood pressure and hypertension. Eur Heart J. 2024;ehae178. doi: 10.1093/eurheartj/ehae178.")
        )
      )
    ),
    
    # --- 评估流程 ---
    "评估流程",
    tabPanel("第一步：适应症评估", icon = icon("check-square"), h3("请勾选患者符合的条件（至少满足一项）"), checkboxGroupInput("indications", label = NULL, choices = c("真性/顽固性难治性高血压" = "refractory", "药物控制不佳的高血压" = "uncontrolled", "降压药物不耐受或依从性差" = "intolerance", "合并高危因素或靶器官损害" = "high_risk")), hr(), h4("各项适应症详细解释："), conditionalPanel("input.indications.includes('refractory')", wellPanel(style = "background-color: #f0f8ff;", strong("真性/顽固性难治性高血压："), tags$ul(tags$li("药物条件：在改善生活方式基础上，规律服用 ≥3 种降压药物（已达最大耐受剂量），且必须包含一种利尿剂。"), tags$li("血压标准：诊室血压(OBP) ≥ 140/90 mmHg，", strong("并且"), "24小时动态血压监测(ABPM)平均收缩压 ≥ 130 mmHg 或日间平均收缩压 ≥ 135 mmHg。")))), conditionalPanel("input.indications.includes('uncontrolled')", wellPanel(style = "background-color: #f0f8ff;", strong("药物控制不佳的高血压："), tags$ul(tags$li("药物条件：使用 ≥2 种降压药物规范治疗后，血压仍显著偏高。"), tags$li("血压标准：OBP ≥ 150/90 mmHg，", strong("并且"), "24小时动态收缩压(ASBP) ≥ 135 mmHg。")))), conditionalPanel("input.indications.includes('intolerance')", wellPanel(style = "background-color: #f0f8ff;", strong("降压药物不耐受或依从性差："), tags$ul(tags$li("不耐受定义：因药物不良反应（如严重咳嗽、水肿、高血钾等）无法坚持服药或达到有效剂量。"), tags$li("依从性差定义：因药物种类过多、服用次数繁琐等原因，患者难以规律服药，导致血压长期控制不佳。")))), conditionalPanel("input.indications.includes('high_risk')", wellPanel(style = "background-color: #f0f8ff;", strong("合并高危因素或靶器官损害："), tags$ul(tags$li("具体表现：已出现左心室肥厚、微量/大量白蛋白尿、颈动脉斑块、心房颤动、动脉粥样硬化性心血管疾病（ASCVD）等。"), tags$li("治疗目标：对于这些高风险患者，期望通过RDN强化降压，带来逆转或延缓靶器官损害的额外获益。"))))
    ),
    tabPanel("第二步：禁忌症筛查", icon = icon("exclamation-triangle"), h3("请确认患者是否存在以下禁忌情况"), p("若以下任意一项为“是”，则通常不建议行RDN治疗。点击", icon("question-circle"), "可查看详细解释。"), fluidRow(column(6, h4("肾脏相关禁忌"), div(radioButtons("contra_egfr", "肾功能严重受损 (eGFR ≤ 40)?", choices = c("否", "是"), inline = TRUE), actionLink("explain_egfr", "查看解释", icon = icon("question-circle"))), div(radioButtons("contra_anatomy", "肾动脉解剖结构不适宜?", choices = c("否", "是"), inline = TRUE), actionLink("explain_anatomy", "查看解释", icon = icon("question-circle"))), div(radioButtons("contra_transplant", "肾移植术后?", choices = c("否", "是"), inline = TRUE), actionLink("explain_transplant", "查看解释", icon = icon("question-circle")))), column(6, h4("心脑血管与全身状况"), div(radioButtons("contra_secondary", "未经治疗的继发性高血压?", choices = c("否", "是"), inline = TRUE), actionLink("explain_secondary", "查看解释", icon = icon("question-circle"))), div(radioButtons("contra_events", "6个月内有严重心脑血管事件?", choices = c("否", "是"), inline = TRUE), actionLink("explain_events", "查看解释", icon = icon("question-circle"))), div(radioButtons("contra_special", "其他禁忌 (如怀孕, 年龄<18)?", choices = c("否", "是"), inline = TRUE), actionLink("explain_special", "查看解释", icon = icon("question-circle")))))
    ),
    tabPanel("第三步：综合评估结果", icon = icon("clipboard-check"), h3("评估摘要"), uiOutput("result_summary")
    ),
    
    # --- 国际指南参考 (V7.0) ---
    "参考信息",
    tabPanel(
      "国际指南推荐",
      icon = icon("globe-americas"),
      h3("RDN在高血压核心指南中的推荐意见"),
      
      wellPanel(style = "background-color: #E8F8F5;",
                h4(icon("book-open"), "推荐级别和证据等级解释"),
                fluidRow(
                  column(6,
                         strong("推荐类别 (Class of Recommendation, COR)"),
                         tags$ul(
                           tags$li(strong("I 类 (强推荐):"), "应执行/应给予。证据和/或普遍共识认为该治疗或操作有益、有用、有效。"),
                           tags$li(strong("IIa 类 (中等推荐):"), "可以执行/可以给予。证据/观点倾向于有用/有效。"),
                           tags$li(strong("IIb 类 (弱推荐):"), "可考虑执行/可考虑给予。证据/观点不确定其有用/有效。"),
                           tags$li(strong("III 类 (不推荐/有害):"), "不应执行/不应给予。证据或普遍共识认为无用/无效，甚至可能有害。")
                         )
                  ),
                  column(6,
                         strong("证据级别 (Level of Evidence, LOE)"),
                         tags$ul(
                           tags$li(strong("A 级:"), "高质量证据，来自多项大型随机对照试验(RCT)或其荟萃分析。"),
                           tags$li(strong("B 级:"), "中等质量证据，来自单项RCT或多项非RCT研究。"),
                           tags$li(strong("C 级:"), "低质量证据，来自观察性研究、病例系列或专家共识。")
                         )
                  )
                )
      ),
      
      tabsetPanel(
        id = "guidelines_tabs",
        
        # --- 美国推荐 ---
        tabPanel("美国推荐", value = "usa",
                 wellPanel(
                   h4("2025 AHA/ACC 成人高血压管理指南"),
                   tags$ul(
                     tags$li(p(strong("推荐意见 (辅助治疗):"), "对于收缩压和舒张压均升高(诊室SBP 140-180 mmHg, DBP ≥90 mmHg)、eGFR ≥40的患者，若在最佳药物治疗下仍为顽固性高血压或对额外药物不耐受，可考虑将RDN作为辅助治疗以降低血压。"), p(strong("推荐等级: "), tags$span("IIb, B-R", style="color: #E69F00; font-weight: bold;"))),
                     tags$li(p(strong("推荐意见 (MDT评估):"), "所有考虑行RDN治疗的患者，都应由在顽固性高血压和RDN领域具有专业知识的多学科团队进行评估。"), p(strong("推荐等级: "), tags$span("I, B-NR", style="color: #009E73; font-weight: bold;"))),
                     tags$li(p(strong("推荐意见 (共同决策):"), "应在共同决策中，充分讨论RDN的降压获益、手术风险，并与药物治疗比较，以确保治疗方案符合患者期望。"), p(strong("推荐等级: "), tags$span("I, C-EO", style="color: #009E73; font-weight: bold;")))
                   ),
                   tags$blockquote(style="font-size: 13px;", "Jones DW, Ferdinand KC, Taler SJ, et al. 2025 AHA/ACC/AANP/AAPA/ABC/ACCP/ACPM/AGS/AMA/ASPC/NMA/PCNA/SGIM Guideline for the Prevention, Detection, Evaluation, and Management of High Blood Pressure in Adults: A Report of the American College of Cardiology/American Heart Association Joint Committee on Clinical Practice Guidelines. J Am Coll Cardiol. Published online May 7, 2025. https://doi.org/10.1016/j.jacc.2025.05.007.")
                 )
        ),
        
        # --- 欧洲推荐 ---
        tabPanel("欧洲推荐", value = "europe",
                 wellPanel(
                   h4("2024 ESC 高血压管理指南"),
                   tags$ul(
                     tags$li(p(strong("推荐意见 (难治性高血压):"), "对于难治性高血压患者，在多学科评估和共同决策后，若患者偏好接受RDN，可考虑进行RDN。"), p(strong("推荐等级: "), tags$span("IIb, B", style="color: #E69F00; font-weight: bold;"))),
                     tags$li(p(strong("推荐意见 (非难治性高血压):"), "对于高心血管风险且使用<3种药物血压仍未控制的患者，在多学科评估和共同决策后，若患者偏好接受RDN，可考虑进行RDN。"), p(strong("推荐等级: "), tags$span("IIb, A", style="color: #E69F00; font-weight: bold;"))),
                     tags$li(p(strong("不推荐 (一线治疗):"), "由于缺乏证明其安全性和心血管结局获益的有力试验证据，不推荐将RDN作为高血压的一线降压干预。"), p(strong("推荐等级: "), tags$span("III, C", style="color: #D55E00; font-weight: bold;")))
                   ),
                   tags$blockquote(style="font-size: 13px;", "McEvoy JW, McCarthy CP, Bruno RM, et al. 2024 ESC Guidelines for the management of elevated blood pressure and hypertension. Eur Heart J. 2024;ehae178. doi: 10.1093/eurheartj/ehae178.")
                 )
        ),
        
        # --- 中国推荐 ---
        tabPanel("中国推荐", value = "china",
                 wellPanel(
                   h4("2024 中国高血压临床实践指南"),
                   p(strong("推荐意见:"), "对于难治性高血压、不能耐受降压药物治疗、临床特征符合交感神经功能亢进的高血压患者，肾脏去交感神经术可作为一种降低血压的策略。"),
                   p(strong("推荐等级: "), tags$span("IIb类", style="color: #E69F00; font-weight: bold;")),
                   p(strong("适用人群特征:")),
                   tags$ul(
                     tags$li(strong("难治性高血压："), "在生活方式干预和足量足疗程使用3种或以上降压药（包括利尿剂）后，血压仍未达标。"),
                     tags$li(strong("药物不耐受："), "因不可避免的药物不良反应而无法坚持标准药物治疗的患者。"),
                     tags$li(strong("交感神经功能亢进特征："), "多见于中青年患者，表现为静息心率偏快、情绪激动时血压显著升高等。")
                   ),
                   tags$blockquote(style="font-size: 13px;", "中华医学会心血管病学分会, 海峡两岸医药卫生交流协会高血压专业委员会, 中国康复医学会心血管疾病预防与康复专业委员会. 中国高血压临床实践指南[J]. 中华心血管病杂志, 2024, 52(9): 985-1032.")
                 )
        )
      )
    ),
    
    tabPanel("完整评估流程", icon = icon("list-ol"), h3("RDN术前标准化评估流程"), p("如果患者初步符合条件，需严格遵循以下流程完成最终评估："), tags$div(class = "list-group", tags$a(href="#", class="list-group-item list-group-item-action", h4(class="list-group-item-heading", "1. 详细的血压评估与医患沟通"), p(class="list-group-item-text", "通过OBPM, HBPM, ABPM确认血压水平，并与患者进行共同决策。")), tags$a(href="#", class="list-group-item list-group-item-action", h4(class="list-group-item-heading", "2. 全面筛查继发性高血压"), p(class="list-group-item-text", "通过病史、体征和实验室检查，排除内分泌性、肾实质性等继发原因。")), tags$a(href="#", class="list-group-item list-group-item-action", h4(class="list-group-item-heading", "3. 实验室检查"), p(class="list-group-item-text", "核心是评估肾功能(eGFR > 40)，同时检查血常规、肝功、电解质等。")), tags$a(href="#", class="list-group-item list-group-item-action", h4(class="list-group-item-heading", "4. 肾动脉影像学评估"), p(class="list-group-item-text", "首选肾动脉CTA，评估血管是否适合手术，排除解剖学禁忌。")), tags$a(href="#", class="list-group-item list-group-item-action active", h4(class="list-group-item-heading", "5. 多学科团队（MDT）决策"), p(class="list-group-item-text", "综合以上所有信息，由MDT共同讨论，做出最终治疗决定。"))))
  )
)

# 3. 定义服务器逻辑 (Server)
server <- function(input, output) {
  observeEvent(input$explain_egfr, { showModal(modalDialog(title = "解释：肾功能严重受损 (eGFR ≤ 40)", p("eGFR过低（≤40 mL/min/1.73m²）被列为禁忌症主要基于：1) 安全性担忧，造影剂可能加重肾损伤；2) 证据不足，几乎所有RDN临床试验都排除了此类患者，缺乏疗效和安全性数据；3) 此类患者手术风险更高，获益不明确。"), easyClose = TRUE, footer = modalButton("关闭")))})
  observeEvent(input$explain_anatomy, { showModal(modalDialog(title = "解释：肾动脉解剖结构不适宜", p("不适宜的解剖结构会极大增加手术难度和并发症风险，或导致无效消融。主要包括：1) 重度肾动脉粥样硬化性狭窄(>70%)；2) 肾动脉纤维肌性发育不良(FMD)；3) 肾动脉瘤；4) 主干过短(<20mm)或过细(<3mm)；5) 存在副肾动脉且供应大量肾实质；6) 既往肾动脉支架植入术后。术前肾动脉CTA/MRA评估至关重要。"), easyClose = TRUE, footer = modalButton("关闭")))})
  observeEvent(input$explain_transplant, { showModal(modalDialog(title = "解释：肾移植术后", p("对移植肾（通常为孤立功能肾）进行RDN是绝对禁忌。任何手术损伤都可能导致肾功能丧失的灾难性后果。且移植肾的神经支配和解剖结构均不适宜行此手术。"), easyClose = TRUE, footer = modalButton("关闭")))})
  observeEvent(input$explain_secondary, { showModal(modalDialog(title = "解释：未经治疗的继发性高血压", p("RDN旨在调节原发性高血压的交感神经过度激活。对于继发性高血压（如原发性醛固酮增多症、嗜铬细胞瘤、肾动脉狭窄等），应首先针对病因进行治疗（如切除肿瘤、支架植入等）。直接行RDN会延误最佳治疗时机，且疗效不佳。"), easyClose = TRUE, footer = modalButton("关闭")))})
  observeEvent(input$explain_events, { showModal(modalDialog(title = "解释：6个月内有严重心脑血管事件", p("近期发生过心肌梗死、不稳定心绞痛、脑卒中或短暂性脑缺血发作(TIA)的患者处于心血管不稳定期。在此期间进行任何有创操作，包括RDN，都可能诱发新的缺血事件。应等待病情稳定（通常建议6个月后）再行评估。"), easyClose = TRUE, footer = modalButton("关闭")))})
  observeEvent(input$explain_special, { showModal(modalDialog(title = "解释：其他特殊禁忌情况", p("包括但不限于：1) 怀孕、计划怀孕或哺乳期（放射线和药物风险）；2) 年龄<18岁（缺乏安全性与有效性数据）；3) 严重肝功能不全（影响凝血功能和药物代谢）；4) 对造影剂或麻醉药物有严重过敏史；5) 预期寿命有限的患者。"), easyClose = TRUE, footer = modalButton("关闭")))})
  
  contraindications_met <- reactive({
    reasons <- c()
    if (input$contra_egfr == "是") reasons <- c(reasons, "肾功能严重受损 (eGFR ≤ 40)")
    if (input$contra_anatomy == "是") reasons <- c(reasons, "肾动脉解剖结构不适宜")
    if (input$contra_transplant == "是") reasons <- c(reasons, "肾移植术后")
    if (input$contra_secondary == "是") reasons <- c(reasons, "未经治疗的继发性高血压")
    if (input$contra_events == "是") reasons <- c(reasons, "6个月内有严重心脑血管事件")
    if (input$contra_special == "是") reasons <- c(reasons, "其他特殊禁忌情况")
    return(reasons)
  })
  
  output$result_summary <- renderUI({
    if (length(input$indications) == 0) {
      return(div(class = "alert alert-warning", role = "alert", h4(icon("bullhorn"), "评估不完整"), p("请先在【第一步：适应症评估】中至少勾选一项患者符合的条件。")))
    }
    contra_reasons <- contraindications_met()
    if (length(contra_reasons) > 0) {
      return(div(class = "alert alert-danger", role = "alert", h4(icon("times-circle"), "不建议行RDN治疗"), p("该患者存在以下一项或多项禁忌症，通常不适合接受RDN治疗："), tags$ul(lapply(contra_reasons, tags$li))))
    }
    return(div(class = "alert alert-success", role = "alert", h4(icon("check-circle"), "患者为RDN的潜在候选人"), p("根据您的选择，该患者初步符合RDN的适应症，且未发现明确的禁忌症。"), p(strong("下一步建议："), "请遵循【完整评估流程】中的指引，并参考【国际指南推荐】，为患者安排全面的临床评估，并提交MDT讨论以做出最终决策。")))
  })
}

# 4. 运行应用
shinyApp(ui = ui, server = server)
