import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    this.exception,
    required this.onRetry,
  });

  final Exception? exception;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return exception != null ? _buildError(context) : _buildLoading(context);
  }

  Widget _buildError(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Failed to load notes'),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
