import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_aqua_farm/core/di/di.dart';
import 'package:smart_aqua_farm/features/library/domain/entity/disease_entity.dart';
import 'package:smart_aqua_farm/features/library/presentation/cubits/fetch_dis/fetch_dis_cubit.dart';
import '../../../../core/navigation/routes.dart';
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
      appBar: CommonAppBar(title: 'Diseases Library').build(context),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<FetchDisCubit, FetchDisState>(
      bloc: _fetchDisCubit,
      builder: (context, state) {
        if (state is FetchDisLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchDisFailure) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else if (state is FetchDisSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildDiseaseList(context, state),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildDiseaseList(BuildContext context, FetchDisSuccess state) {
    final diseases = state.diseases;
    return ListView.separated(
      itemCount: diseases.length,
      separatorBuilder: (context, index) {
        return const Divider(height: 15, color: Colors.grey);
      },
      itemBuilder: (context, idx) {
        return InkWell(
          onTap: () {
            context.go(
              "${MyRoutes.library}/${MyRoutes.diseasesDetails}",
              extra: diseases[idx].name,
            );
          },
          child: _diseaseInfoTile(context, state.diseases, idx),
        );
      },
    );
  }

  Widget _diseaseInfoTile(
    BuildContext context,
    List<DiseaseEntity> list,
    int idx,
  ) {
    return Row(
      children: [
        _imageContainer(context, list, idx),
        _info(idx, list, context),
        Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _info(int idx, List<DiseaseEntity> list, BuildContext context) {
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
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
      ),
    );
  }

  Container _imageContainer(
    BuildContext context,
    List<DiseaseEntity> list,
    int idx,
  ) {
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
}
