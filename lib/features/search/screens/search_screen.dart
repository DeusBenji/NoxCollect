import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/providers.dart';
import '../../../domain/models/card_models.dart';
import '../../../data/repositories/visual_recognition_repository.dart';
import '../widgets/advanced_add_sheet.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _visualRepo = VisualRecognitionRepository(); // Can also be provided via Riverpod in future
  
  Timer? _debounce;
  List<CardModel> _results = [];
  bool _isLoading = false;
  String _error = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _error = '';
        _isLoading = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      try {
        final cards = await _visualRepo.searchCatalog(query);
        if (mounted) {
          setState(() {
            _results = cards;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _error = e.toString();
            _isLoading = false;
          });
        }
      }
    });
  }
  
  void _showAdvancedAddSheet(CardModel card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AdvancedAddSheet(card: card),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name and number (e.g. Gourgeist 041)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_error.isNotEmpty)
            Expanded(child: Center(child: Text('Error: $_error', style: const TextStyle(color: Colors.red))))
          else if (_results.isEmpty && _searchController.text.isNotEmpty)
            const Expanded(child: Center(child: Text('No cards found.')))
          else if (_results.isEmpty)
            const Expanded(child: Center(child: Text('Type to search for cards', style: TextStyle(color: Colors.grey))))
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58, // slightly taller for new content
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final card = _results[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade200,
                                child: card.imageUrlSmall != null
                                    ? CachedNetworkImage(
                                        imageUrl: card.imageUrlSmall!,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(
                                          Icons.broken_image,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      if (card.setSymbolUrl != null) ...[
                                        CachedNetworkImage(
                                          imageUrl: card.setSymbolUrl!,
                                          height: 14,
                                          width: 14,
                                          errorWidget: (c, u, e) => Text(
                                            card.setCode ?? '?',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                      ] else
                                        Text(
                                          '${card.setCode ?? "?"} • ',
                                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                        ),
                                      Text(
                                        '#${card.cardNumber}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    card.rarity ?? 'Unknown Rarity',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.teal.shade400,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '15 kr',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Material(
                            color: Colors.blue.shade600,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => _showAdvancedAddSheet(card),
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.add, size: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
