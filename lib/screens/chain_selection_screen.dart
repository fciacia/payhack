import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/chain_status_widget.dart';

class ChainSelectionScreen extends StatefulWidget {
  final bool advancedMode;
  const ChainSelectionScreen({super.key, this.advancedMode = false});

  @override
  State<ChainSelectionScreen> createState() => _ChainSelectionScreenState();
}

class _ChainSelectionScreenState extends State<ChainSelectionScreen> {
  List<Map<String, dynamic>> chains = [
    {
      'id': 'eth',
      'name': 'Ethereum',
      'logo': 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
      'status': 'Online',
      'avgFee': '18.2',
      'blockTime': '13s',
      'gasPrice': '32 Gwei',
      'preferred': false,
      'popularity': 100,
    },
    {
      'id': 'bnb',
      'name': 'BNB Chain',
      'logo': 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
      'status': 'Delayed',
      'avgFee': '0.12',
      'blockTime': '3s',
      'gasPrice': '4 Gwei',
      'preferred': false,
      'popularity': 80,
    },
    {
      'id': 'polygon',
      'name': 'Polygon',
      'logo': 'https://cryptologos.cc/logos/polygon-matic-logo.png',
      'status': 'Online',
      'avgFee': '0.03',
      'blockTime': '2s',
      'gasPrice': '0.8 Gwei',
      'preferred': true,
      'popularity': 70,
    },
    {
      'id': 'sol',
      'name': 'Solana',
      'logo': 'https://cryptologos.cc/logos/solana-sol-logo.png',
      'status': 'Congested',
      'avgFee': '0.00025',
      'blockTime': '0.4s',
      'gasPrice': 'N/A',
      'preferred': false,
      'popularity': 90,
    },
    {
      'id': 'arbitrum',
      'name': 'Arbitrum',
      'logo': 'https://cryptologos.cc/logos/arbitrum-arb-logo.png',
      'status': 'Online',
      'avgFee': '0.18',
      'blockTime': '1.2s',
      'gasPrice': '0.2 Gwei',
      'preferred': false,
      'popularity': 60,
    },
    {
      'id': 'optimism',
      'name': 'Optimism',
      'logo': 'https://cryptologos.cc/logos/optimism-ethereum-op-logo.png',
      'status': 'Online',
      'avgFee': '0.15',
      'blockTime': '1.1s',
      'gasPrice': '0.2 Gwei',
      'preferred': false,
      'popularity': 55,
    },
  ];
  Set<String> preferred = {};
  String filter = 'All';
  String sort = 'Popularity';
  String search = '';

  @override
  void initState() {
    super.initState();
    _loadPreferred();
  }

  Future<void> _loadPreferred() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      preferred = prefs.getStringList('preferredChains')?.toSet() ?? {};
      for (var c in chains) {
        c['preferred'] = preferred.contains(c['id']);
      }
    });
  }

  Future<void> _togglePreferred(String id) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (preferred.contains(id)) {
        preferred.remove(id);
      } else {
        preferred.add(id);
      }
      prefs.setStringList('preferredChains', preferred.toList());
      for (var c in chains) {
        c['preferred'] = preferred.contains(c['id']);
      }
    });
  }

  void _showDetails(Map<String, dynamic> chain) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'chain-logo-${chain['id']}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.network(
                    chain['logo'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              chain['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text('Status: ${chain['status']}'),
            Text('Avg Fee: ${chain['avgFee']}'),
            Text('Block Time: ${chain['blockTime']}'),
            Text('Gas Price: ${chain['gasPrice']}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredSortedChains {
    List<Map<String, dynamic>> filtered = chains
        .where(
          (c) =>
              c['name'].toString().toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
    if (filter != 'All') {
      filtered = filtered.where((c) => c['status'] == filter).toList();
    }
    if (sort == 'Popularity') {
      filtered.sort(
        (a, b) => (b['popularity'] ?? 0).compareTo(a['popularity'] ?? 0),
      );
    } else if (sort == 'Fee') {
      filtered.sort(
        (a, b) => double.tryParse(
          a['avgFee'] ?? '0',
        )!.compareTo(double.tryParse(b['avgFee'] ?? '0')!),
      );
    } else if (sort == 'Name') {
      filtered.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Blockchain')),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chains...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              onChanged: (v) => setState(() => search = v),
            ),
          ),
          // Filter chips and sort dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: filter == 'All',
                        onSelected: (_) => setState(() => filter = 'All'),
                      ),
                      FilterChip(
                        label: const Text('Online'),
                        selected: filter == 'Online',
                        onSelected: (_) => setState(() => filter = 'Online'),
                      ),
                      FilterChip(
                        label: const Text('Delayed'),
                        selected: filter == 'Delayed',
                        onSelected: (_) => setState(() => filter = 'Delayed'),
                      ),
                      FilterChip(
                        label: const Text('Congested'),
                        selected: filter == 'Congested',
                        onSelected: (_) => setState(() => filter = 'Congested'),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: sort,
                    items: const [
                      DropdownMenuItem(
                        value: 'Popularity',
                        child: Text('Popularity'),
                      ),
                      DropdownMenuItem(value: 'Fee', child: Text('Fee')),
                      DropdownMenuItem(value: 'Name', child: Text('Name')),
                    ],
                    onChanged: (v) => setState(() => sort = v!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ),
          ),
          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.95,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredSortedChains.length,
              itemBuilder: (context, i) {
                final chain = _filteredSortedChains[i];
                return GestureDetector(
                  onTap: () => _showDetails(chain),
                  child: Hero(
                    tag: 'chain-logo-${chain['id']}',
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.network(
                                      chain['logo'],
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                            size: 28,
                                          ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    chain['preferred']
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: chain['preferred']
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  onPressed: () =>
                                      _togglePreferred(chain['id']),
                                ),
                              ],
                            ),
                            Text(
                              chain['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            ChainStatusWidget(status: chain['status']),
                          ],
                        ),
                      ),
                    ),
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
