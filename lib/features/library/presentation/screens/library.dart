import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_aqua_farm/core/di/di.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/disease_entity.dart';
import 'package:smart_aqua_farm/features/library/presentation/cubits/fetch_dis/fetch_dis_cubit.dart';
import '../../../../core/widgets/app_bar.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _fetchDisCubit = getIt<FetchDisCubit>();
  @override
  void dispose() {
    _fetchDisCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _fetchDisCubit.fetchDiseases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar().build(context),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          ListView.separated(
            itemBuilder: (context, idx) {
              return GestureDetector(
                child: _diseaseInfoTile(context, idx),
                onTap: () {
                  // context.go(location);
                },
              );
            },
            separatorBuilder: (context, idx) {
              return Divider(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
              );
            },
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }

  Widget _diseaseInfoTile(BuildContext context, int idx) {
    return BlocBuilder<FetchDisCubit, FetchDisState>(
      bloc: _fetchDisCubit,
      builder: (context, state) {
        if (state is FetchDisLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchDisFailure) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        } else if (state is FetchDisSuccess) {
          return Row(
            children: [
              _imageContainer(context, idx),
              _info(idx, context),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 10),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _info(int idx, BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(
          list[idx].name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          list[idx].description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Container _imageContainer(BuildContext context, int idx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(list[idx].url, fit: BoxFit.cover),
      ),
    );
  }

  final List<DiseaseEntity> list = [
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
    DiseaseEntity(
      id: '1',
      name: 'Bacterial Red',
      description:
          'Bacterial Red disease is a red disease occurred by bacteria',
      url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg/1200px-Pacific_double-saddle_butterflyfish_%28Chaetodon_ulietensis%29_and_other_Chaetodon_Moorea.jpg',
    ),
  ];
}
/**
 * return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(list[idx].url),
              ),
              title: Text(list[idx].name),
              subtitle: Text(list[idx].description),
            );
 */