import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gits_inspector/src/cubit/gits_inspector_cubit.dart';
import 'package:gits_inspector/src/extensions/date_time_extensions.dart';
import 'package:gits_inspector/src/extensions/inspector_extensions.dart';
import 'package:gits_inspector/src/models/inspector.dart';

class ItemInspector extends StatelessWidget {
  const ItemInspector({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Inspector item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          context.read<GitsInspectorCubit>().navigateToDetail(context, item),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35,
            child: Text(
              item.response?.status?.toString() ?? '! ! !',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: item.colorStatus,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.pathWithQuery,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: item.colorStatus,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      item.isSSL ? Icons.lock_outline : Icons.lock_open,
                      size: 14,
                      color: item.isSSL ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(item.request.url.host),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.createdAt.toHHMMSS(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item.duration,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      item.totalSize,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
