import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/ui/pages/mine/widgets/mine_booklist_section.dart';
import 'package:i_reader/ui/pages/mine/widgets/mine_read_rank_section.dart';
import 'package:i_reader/ui/widgets/td/td_action_button.dart';
import 'package:remixicon/remixicon.dart';
import 'package:i_reader/ui/pages/mine/widgets/mine_read_section.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class MinePage extends ConsumerWidget {
  const MinePage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '我的',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: HomePalette.primaryText(context),
                        ),
                      ),
                    ),
                    TDActionButton(
                      icon: Remix.settings_line,
                      onTap: () => context.push("/settings"),
                    ),
                    const SizedBox(width: 12),
                    TDActionButton(
                      icon: Remix.information_line,
                      onTap: () => context.pushNamed("about"),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    children: [
                      const SizedBox(height: 8),
                      _buildHeroCard(context),
                      const SizedBox(height: 24),
                      MineReadRankSection(),
                      const SizedBox(height: 20),
                      MineReadSection(),
                      const SizedBox(height: 20),
                      MineBooklistSection(),
                      const SizedBox(height: 30),
                      _buildFooter(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F7CFF).withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.menu_book_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "一阅",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "但行好事，莫问前程",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          Text(
            '于无序处立心，于荒野处见性，于繁华处修行',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: HomePalette.tertiaryText(context),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
