import 'dart:async';
import 'package:flutter/material.dart';

class NotificationItem {
  final String name;
  final String description;
  final String icon;
  final Color color;
  final String time;

  const NotificationItem({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.time,
  });
}

class AnimatedNotificationList extends StatefulWidget {
  final List<NotificationItem> notifications;
  final Duration delay;

  const AnimatedNotificationList({
    super.key,
    required this.notifications,
    this.delay = const Duration(milliseconds: 1000),
  });

  @override
  State<AnimatedNotificationList> createState() =>
      _AnimatedNotificationListState();
}

class _AnimatedNotificationListState extends State<AnimatedNotificationList> {
  final List<NotificationItem> _visibleNotifications = [];
  static const double cardHeight = 92.0; // Height of card + padding
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scheduleNextNotification();
  }

  void _scheduleNextNotification() {
    if (_currentIndex >= widget.notifications.length) return;
    _timer = Timer(widget.delay, () {
      if (!mounted) return;
      setState(() {
        _visibleNotifications.insert(0, widget.notifications[_currentIndex]);
        _currentIndex++;
      });
      _scheduleNextNotification();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double listHeight = _visibleNotifications.isEmpty
        ? 100.0
        : (_visibleNotifications.length * cardHeight);
    return Container(
      height: listHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(_visibleNotifications.length, (index) {
          return AnimatedNotificationCard(
            key: ValueKey(_visibleNotifications[index].hashCode),
            item: _visibleNotifications[index],
            index: index,
            topOffset: index * cardHeight,
          );
        }),
      ),
    );
  }
}

class AnimatedNotificationCard extends ImplicitlyAnimatedWidget {
  final NotificationItem item;
  final int index;
  final double topOffset;

  const AnimatedNotificationCard({
    super.key,
    required this.item,
    required this.index,
    required this.topOffset,
  }) : super(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

  @override
  AnimatedNotificationCardState createState() =>
      AnimatedNotificationCardState();
}

class AnimatedNotificationCardState
    extends AnimatedWidgetBaseState<AnimatedNotificationCard> {
  Tween<double>? _topTween;
  Tween<double>? _slideTween;

  @override
  void initState() {
    super.initState();
    _slideTween = Tween<double>(begin: -100.0, end: 0.0);
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _topTween = visitor(
      _topTween,
      widget.topOffset,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;

    _slideTween = visitor(
      _slideTween,
      0.0,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    final topOffset = _topTween?.evaluate(animation) ?? widget.topOffset;
    final slideOffset = _slideTween?.evaluate(animation) ?? 0.0;

    return Positioned(
      top: topOffset,
      left: 0,
      right: 0,
      child: Transform.translate(
        offset: Offset(slideOffset, 0),
        child: Opacity(
          opacity: (1 - (slideOffset.abs() / 100)).clamp(0.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: NotificationCard(
              item: widget.item,
              index: widget.index,
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final int index;

  const NotificationCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      item.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('·'),
                          const SizedBox(width: 4),
                          Text(
                            item.time,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
}

class NotificationDemo extends StatelessWidget {
  const NotificationDemo({super.key});

  final List<NotificationItem> notifications = const [
    NotificationItem(
      name: "Cha-ching! 💰",
      description:
          "Someone actually paid! Time to buy that yacht... or maybe just coffee",
      time: "15m ago",
      icon: "💸",
      color: Color(0xFF00C9A7),
    ),
    NotificationItem(
      name: "Fresh ..err, user!",
      description: "Another brave soul joins our awesome chaos",
      time: "10m ago",
      icon: "👤",
      color: Color(0xFFFFB800),
    ),
    NotificationItem(
      name: "Inbox invasion!",
      description: "Someone's spamming... with love ❤️",
      time: "5m ago",
      icon: "💬",
      color: Color(0xFFFF3D71),
    ),
    NotificationItem(
      name: "Plot twist ahead!",
      description: "Breaking news: Developer finds missing semicolon",
      time: "2m ago",
      icon: "🗞️",
      color: Color(0xFF1E86FF),
    ),
    NotificationItem(
      name: "Money shower! 🚿",
      description: "Ka-ching! Time to make it rain... responsibly",
      time: "15m ago",
      icon: "💸",
      color: Color(0xFF00C9A7),
    ),
    NotificationItem(
      name: "New player entered!",
      description: "Welcome to the circus! Grab your popcorn 🍿",
      time: "10m ago",
      icon: "👤",
      color: Color(0xFFFFB800),
    ),
    NotificationItem(
      name: "Urgent message!",
      description: "Your cat posted on your behalf again",
      time: "5m ago",
      icon: "💬",
      color: Color(0xFFFF3D71),
    ),
    NotificationItem(
      name: "Stop the presses!",
      description: "Coffee machine is now accepting high-fives",
      time: "2m ago",
      icon: "🗞️",
      color: Color(0xFF1E86FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navigator.canPop(context)
          ? AppBar(
              title: const Text('Notification Feed'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AnimatedNotificationList(
                notifications: notifications,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
