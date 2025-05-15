import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_aqua_farm/core/di/di.dart';
import 'package:smart_aqua_farm/core/widgets/app_bar.dart';
import 'package:smart_aqua_farm/features/library/presentation/cubits/dis_details/dis_details_cubit.dart';

class DisDetailsScreen extends StatefulWidget {
  const DisDetailsScreen({super.key, required this.diseaseName});
  final String diseaseName;

  @override
  State<DisDetailsScreen> createState() => _DisDetailsState();
}

class _DisDetailsState extends State<DisDetailsScreen> {
  final DisDetailsCubit _disDetailsCubit = getIt<DisDetailsCubit>();

  @override
  void dispose() {
    _disDetailsCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _disDetailsCubit.fetchDiseaseDetails(widget.diseaseName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar().build(context),
      body: BlocBuilder<DisDetailsCubit, DisDetailsState>(
        bloc: _disDetailsCubit,
        builder: (context, state) {
          if (state is DisDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DisDetailsFailure) {
            return Center(
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          } else if (state is DisDetailsSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(state.imageUrl),
                    SizedBox(height: 8),
                    Text(
                      state.diseaseName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      state.diseaseDescription,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Symptoms:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    ..._commaSeparatedString(
                      str: state.diseaseSymptoms,
                      context: context,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Treatment:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    ..._commaSeparatedString(
                      str: state.diseaseTreatment,
                      context: context,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  List<Widget> _commaSeparatedString({
    required String str,
    required BuildContext context,
    required TextStyle style,
  }) {
    final s = str.split(',').map((e) => e.trim()).toList();
    int i = 0;
    return s.map((e) => Text("${i++}. $e", style: style)).toList();
  }
}
