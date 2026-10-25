"""Builds web/resume.pdf. Keep the content in sync with lib/data/*.dart.

Run from the repo root: python3 tool/resume/build_resume.py
"""
from pathlib import Path

from reportlab.lib.colors import HexColor
from reportlab.lib.enums import TA_CENTER, TA_RIGHT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import (Flowable, PageBreak, Paragraph, SimpleDocTemplate,
                                Spacer, Table, TableStyle)

OUT = Path(__file__).resolve().parents[2] / 'web' / 'resume.pdf'

INK = HexColor('#1a1a1a')
MUTED = HexColor('#6b6b6b')
LINK = HexColor('#1f4e79')
MARGIN = 42.52
FRAME_PAD = 6  # SimpleDocTemplate's frame padding; body text sits inside it
WIDTH = A4[0] - 2 * MARGIN
RIGHT_COL = 163.28

FONT = 'Helvetica'
BOLD = 'Helvetica-Bold'


def style(size, leading, color=INK, font=FONT, **kw):
    return ParagraphStyle(f'{font}{size}{leading}', fontName=font, fontSize=size,
                          leading=leading, textColor=color, **kw)


NAME = style(17, 21, font=BOLD, alignment=TA_CENTER)
TITLE = style(11, 14, MUTED, alignment=TA_CENTER)
CONTACT = style(9, 12, font=BOLD, alignment=TA_CENTER)
BODY = style(8.6, 11.5, leftIndent=6, rightIndent=6)
ORG = style(10.5, 13)
ROLE = style(10, 13)
META = style(9.5, 13, alignment=TA_RIGHT)
SUB = style(8.5, 11, leftIndent=6, rightIndent=6)
BULLET = style(8.5, 10.9, leftIndent=15, rightIndent=6, firstLineIndent=1.5, bulletIndent=7,
               bulletFontSize=10)
ACH_TITLE = style(10, 13)
ACH_BODY = style(8.6, 11.5)


def link(text, url):
    return f'<a href="{url}" color="#1f4e79"><u>{text}</u></a>'


class SectionHeader(Flowable):
    """Centered heading with a full-width rule underneath."""

    def __init__(self, text):
        super().__init__()
        self.text = text

    def wrap(self, *_):
        return WIDTH, 20

    def draw(self):
        c = self.canv
        c.setFillColor(INK)
        c.setFont(FONT, 11.5)
        c.drawCentredString(WIDTH / 2, 5.5, self.text)
        c.setStrokeColor(INK)
        c.setLineWidth(0.7)
        c.line(0, 0, WIDTH, 0)


def section(title):
    return [SectionHeader(title), Spacer(1, 4)]


def row(left, right, left_style):
    t = Table([[Paragraph(left, left_style), Paragraph(right, META)]],
              colWidths=[WIDTH - RIGHT_COL, RIGHT_COL], rowHeights=[14])
    t.setStyle(TableStyle([('LEFTPADDING', (0, 0), (-1, -1), 0),
                           ('RIGHTPADDING', (0, 0), (-1, -1), 0),
                           ('TOPPADDING', (0, 0), (-1, -1), 0),
                           ('BOTTOMPADDING', (0, 0), (-1, -1), 0),
                           ('VALIGN', (0, 0), (-1, -1), 'BOTTOM')]))
    return t


def entry(org, role, meta_top, meta_bottom, bullets, url=None, subtitle=None):
    name = link(org, url) if url else f'<font color="#6b6b6b">{org}</font>'
    out = [row(name, meta_top, ORG), row(role, meta_bottom, ROLE)]
    if subtitle:
        out.append(Paragraph(subtitle, SUB))
    out.append(Spacer(1, 2))
    out += [Paragraph(b, BULLET, bulletText='•') for b in bullets]
    out.append(Spacer(1, 4))
    return out


def skill(label, value):
    return [Paragraph(f'<font color="#6b6b6b">{label}:</font> {value}', BODY), Spacer(1, 3)]


BLINK22 = 'https://www.blink22.com/team/'
PLAY = 'https://play.google.com/store/apps/details?id='
SEP = '&nbsp; | &nbsp;'

story = [
    Paragraph('ABANOUB ASHRAF EZZAT ZAKI MICHAEL', NAME),
    Paragraph('Software Development Engineer', TITLE),
    Spacer(1, 4),
    Paragraph(SEP.join(['Baden-Württemberg, Germany', '+49 152 1453 5320', 'abanoub4055@gmail.com',
                        link('GitHub', 'https://github.com/AbanoubZaki'),
                        link('LinkedIn', 'https://www.linkedin.com/in/abanoub-michael-53b192164'),
                        link('Portfolio', 'https://abanoubzaki.github.io/my-portfolio/')]),
              CONTACT),
    Spacer(1, 5),
    *section('Summary'),
    Paragraph('Software Development Engineer with 5+ years of professional experience in Flutter and '
              'native iOS development. Expert in building scalable mobile and web applications using '
              'clean architecture and modern state management patterns. Proven track record leading '
              'cross-functional teams, optimizing performance and infrastructure costs, and delivering '
              'high-quality, user-focused solutions across 30+ production applications. Uses AI coding '
              'agents such as Claude Code and Codex daily to accelerate delivery while maintaining code '
              'quality.', BODY),
    Spacer(1, 5),
    *section('Skills'),
    *skill('Technical Skills', 'Flutter, Dart, iOS (Swift, SwiftUI), Clean Architecture, State '
           'Management (Bloc, Riverpod, Provider, Cubit), MVVM, VIPER, RESTful APIs, Firebase, Git, '
           'CI/CD (Codemagic), SQLite, Google Maps API, ARKit, OOP, Data Structures, Algorithms'),
    *skill('AI-Assisted Development', 'Claude Code, OpenAI Codex, AI coding agents for daily '
           'development, refactoring, code review, debugging and test generation'),
    *skill('Soft Skills', 'Leadership, Problem-Solving, Collaboration, Time Management, Team '
           'Management, Effective Communication'),
    *skill('Languages', 'Arabic (Native), English (Proficient, C1), German (Elementary, A2)'),
    Spacer(1, 2),
    *section('Experience'),
    *entry('Blink22', 'Full-time Software Development Engineer (Flutter and native iOS)',
           'Dubai, United Arab Emirates', '08/2021 - 11/2025', [
               'Developed Flutter apps with Provider and Bloc, and native iOS features in Swift and '
               'SwiftUI using MVVM, VIPER and clean architecture, including a UAE government app.',
               'Optimized performance across multiple Flutter and iOS projects.',
           ], BLINK22, 'Software Development Company'),
    *entry('GLI Global Lean Industry 4.0', 'Part-time Software Development Team Leader (Flutter)',
           'Dubai, United Arab Emirates', '01/2022 - 11/2025', [
               'Led a team of 10+ developers across concurrent Flutter projects.',
               'Owned architecture and development workflows for the LeanGo platform: 10+ Industry 4.0 '
               'apps on Android, iOS and web.',
               'Refactored the legacy LeanGo Dashboard and LeanGo CIL codebases.',
               'Reduced infrastructure costs by 30% through efficient Firebase resource allocation.',
               'Achieved a 75% bug reduction through continuous testing and feedback loops.',
           ], 'https://grwangroup.com/global-lean-industry-4-0/', 'Global Lean Industry'),
    *entry('Wellx AI', 'Contract Software Development Engineer (Flutter)',
           'Dubai, United Arab Emirates', 'Contract · 07/2025 - 09/2025', [
               'Worked on Wellx, an AI-powered health insurance app that uses behaviour and well-being '
               'data to make coverage proactive rather than reactive.',
               'Built the emotion-tracking module and the tracked-emotions statistics screen in Flutter.',
           ], 'https://wellxai.com/', 'AI-Powered Health Insurance'),
    *entry('Blink22', 'Mobile Development Internship (iOS)', 'Alexandria, Egypt',
           '07/2020 - 09/2020', [
               'Developed an ARKit image tracking app for product recognition.',
               'Contributed to iOS apps using Swift and VIPER.',
           ], BLINK22, 'Software Development Company'),
    *entry('ITSpark', 'Mobile Development Internship (Flutter)', 'Alexandria, Egypt',
           '07/2019 - 09/2019', [
               'Converted an online pharmacy app from native Android to Flutter.',
               'Worked on a Flutter online market app.',
           ], 'https://itspark-eg.com/', 'Software Development Company'),
    PageBreak(),
    *section('Education'),
    row('<font color="#6b6b6b">Alexandria University</font>', 'Alexandria, Egypt', ORG),
    row('B.S. in Computer and Systems Engineering', '09/2016 - 06/2021', ROLE),
    Paragraph('Grade: 87.6% (Excellent with degree of honor)', style(8.6, 11.5, leftIndent=6, rightIndent=6)),
    Spacer(1, 5),
    *section('Projects'),
    *entry('LeanGo Platform', 'Software Development Team Leader (Flutter)', '', '01/2022 - Present', [
        'Leading development of a full suite of 10+ Industry 4.0 manufacturing apps: '
        f'{link("LeanGo Dashboard", "https://leango.app/")}, '
        f'{link("STM Dashboard", "https://dev.stm.leango.app/")}, STM Mobile '
        f'({link("Android", PLAY + "com.grwan.leango_stm")}, '
        f'{link("iOS", "https://apps.apple.com/app/leango-stm/id6768351967")}), CIL '
        f'({link("Android", PLAY + "com.grwan.leango_cil")}, '
        f'{link("iOS", "https://apps.apple.com/de/app/leango-cil/id1632797745")}), MES '
        f'({link("Android", PLAY + "com.grwan.leango_mes")}, '
        f'{link("iOS", "https://apps.apple.com/de/app/leango-mes/id6448866952")}), Trace '
        f'({link("Android", PLAY + "com.grwan.leango_trace.dev")}, '
        f'{link("iOS", "https://apps.apple.com/ch/app/leango-trace-dev/id6471980417")}), '
        f'{link("HACCP", PLAY + "com.grwan.leango_haccp")}, '
        f'{link("ARTEX engage", PLAY + "com.grwan.artex.engage")}.',
        'Built all platform apps from scratch and shipped them to Google Play, the App Store and the '
        'web, covering analytics, maintenance, traceability and food safety.',
        'Built the LeanGo and STM dashboards with Flutter Web, with shared architecture, CI/CD, and '
        'responsive, accessible UI.',
    ]),
    *entry('Salik', 'iOS app using SwiftUI', '', '02/2025 - 03/2026', [
        'Contributed to the Salik app for the UAE government, implementing features in SwiftUI using '
        'MVVM and clean architecture.',
        'Worked on key modules including Transactions, Vehicles, Services, Settings, Profile, and News, '
        'meeting government-grade quality standards.',
    ], 'https://apps.apple.com/ae/app/smart-salik/id912158362'),
    *entry('Memo Rush', 'Personal project using Flutter', '', '11/2025 - 01/2026', [
        'Designed, developed and published an emoji card-matching memory game on the Google Play Store, '
        'end to end and solo.',
    ], PLAY + 'com.abanoub.memo.rush'),
    *entry('MUAB', 'Flutter app (Education)', '', '04/2023 - 12/2023', [
        'An education ecosystem and social learning network with a personalized, AI-driven feed.',
        'Built the login, home content feed, explore (user and post search), and user profile screens, '
        'plus the block-users feature.',
    ], 'https://apps.apple.com/sa/app/muab/id6444184362'),
    *entry('LIBRA', 'iOS app using Swift', '', '10/2022 - 05/2023', [
        'Implemented user-to-user VoIP calls inside the app, handling all related edge cases.',
        'Built the invite-a-friend module using text messages and QR codes.',
    ]),
    *entry('SALT', 'Project Lead using Flutter', '', '03/2022 - 09/2022', [
        'Led the development team from project inception to production deployment, building the '
        'Salt.one app using Flutter.',
        'Defined the development workflow, including CI/CD tools, state management patterns, modular '
        'file architecture, and clean code conventions.',
        'Developed the Buy and Sell Gold module, the mutual fund investment module, and an AI-powered '
        'chat module that helps users track expenses.',
    ]),
    *entry('Khatabook', 'iOS app using Swift', '', '01/2022 - 09/2022', [
        'A business management app built with Swift using the VIPER architecture.',
        'Built the module for sending and receiving money between users through real, secure bank '
        'transfers, plus transaction status and history screens.',
    ], 'https://apps.apple.com/in/app/khatabook-vyapar-app/id1488204139'),
    Spacer(1, 4),
    *section('Key Achievements'),
    Spacer(1, 3),
    Paragraph(link('Google DSC Solution Challenge 2020',
                   'https://drive.google.com/file/d/1ULz-V-7xlpLbWq1ddGqOaercu9dCgDIZ/view?usp=sharing'),
              ACH_TITLE),
    Paragraph('Qualified among the best 13 teams in the MENA region for the semi-final round with the '
              'ResQ app.', ACH_BODY),
]

SimpleDocTemplate(str(OUT), pagesize=A4, leftMargin=MARGIN - FRAME_PAD,
                  rightMargin=MARGIN - FRAME_PAD, topMargin=34, bottomMargin=34, title='Abanoub Michael - Resume',
                  author='Abanoub Michael').build(story)
print(f'Wrote {OUT}')
