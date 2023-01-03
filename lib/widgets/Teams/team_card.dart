import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/models/team/team_model.dart';
import 'package:ocyclient/widgets/Teams/member/member_vertical.dart';
import 'package:ocyclient/widgets/Teams/member/member_horizontal.dart';
import 'package:responsive_grid/responsive_grid.dart';

class TeamCard extends StatefulWidget {
  final Size size;
  final String title;
  final List<Member> members;

  const TeamCard(
      {Key? key,
      required this.size,
      required this.title,
      required this.members})
      : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool isExpanded = true;

  @override
  void initState() {
    if (widget.members.isEmpty) {
      setState(() {
        isExpanded = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xff152839),
        child: ExpansionTile(
          initiallyExpanded: widget.members.isNotEmpty,
          onExpansionChanged: (bool value) {
            setState(() {
              isExpanded = value;
            });
          },
          trailing: const SizedBox(),
          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 22,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: "PublicSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: widget.size.width > 1100
                        ? 40
                        : widget.size.width > 800
                            ? 30
                            : 25,
                  ),
                ),
                const Spacer(),
                Icon(
                  isExpanded
                      ? FontAwesomeIcons.circleMinus
                      : FontAwesomeIcons.circlePlus,
                  color: Colors.white,
                  size: widget.size.width > 800 ? 40 : 25,
                ),
                if (widget.size.width > 800)
                  const SizedBox(
                    width: 22,
                  ),
              ],
            ),
          ),
          children: [
            if (widget.members.isNotEmpty) ...[
              ResponsiveGridList(
                desiredItemWidth:
                    widget.size.width < 480 ? widget.size.width - 50 : 430,
                scroll: false,
                rowMainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  widget.members.length,
                  (index) {
                    Member member = widget.members[index];
                    return widget.size.width > 500
                        ? MemberHorizontal(member: member)
                        : MemberVertical(member: member);
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ] else ...[
              const Text(
                "No members found",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PublicSans"),
              ),
              const SizedBox(
                height: 30,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
